import 'dart:convert';

import 'package:flutter_app_analytics/flutter_app_analytics.dart';
import 'package:flutter_app_analytics_laudspeaker_provider/laudspeaker_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_doubles.dart';

void main() {
  group('Laudspeaker Provider - ', () {
    test('identify', () {
      final provider = LaudspeakerProvider(apiKey: 'test_key');

      provider.identify(userId: 'test_user_id');
      expect(provider.getUserId(), 'test_user_id');
    });
  });

  test('trackEvent', () async {
    final client = ClientTestDouble();
    final provider = LaudspeakerProvider(apiKey: 'test_key', client: client);
    final event = AnalyticsEvent(
      name: 'test_event',
      properties: {'test_property': 'test_value'},
    );

    await provider.trackEvent(event);
    Map<String, String> expectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Api-Key test_key'
    };
    var expectedBody = json.encode({
      "correlationKey": "externalId",
      "correlationValue": null,
      "event": {
        "name": event.name,
        "properties": event.properties,
      }
    });
    expect(client.posts.first.headers, expectedHeaders);
    expect(client.posts.first.body, expectedBody);
  });

  test('trackEvents', () async {
    final client = ClientTestDouble();
    final provider = LaudspeakerProvider(apiKey: 'test_key', client: client);
    final event = AnalyticsEvent(
      name: 'test_event1',
      properties: {'test_property': 'test_value1'},
    );
    final event2 = AnalyticsEvent(
      name: 'test_event2',
      properties: {'test_property': 'test_value2'},
    );

    await provider.trackEvents([event, event2]);

    expect(client.posts.length, 2);
    expect(client.posts[0].body.toString().contains('test_event1'), true);
    expect(client.posts[1].body.toString().contains('test_event2'), true);
  });
}
