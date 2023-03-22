library flutter_app_analytics_laudspeaker_provider;

import 'dart:convert';

import 'package:flutter_app_analytics/flutter_app_analytics.dart';
import 'package:flutter_app_analytics_laudspeaker_provider/http_client_wrapper.dart';
import 'package:flutter_app_analytics_laudspeaker_provider/http_client_wrapper_interface.dart';

class LaudspeakerProvider implements AnalyticsProvider {
  @override
  List<String> allowedUserProperties;

  final String _apiKey;
  String? _userId;
  final HttpClientWrapperInterface _client;
  final String laudspeakerHost = 'api.laudspeaker.com';

  LaudspeakerProvider(
      {required String apiKey,
      HttpClientWrapperInterface? client,
      List<String>? allowedProperties})
      : _apiKey = apiKey,
        _client = client ?? HttpClientWrapper(),
        allowedUserProperties = allowedProperties ?? [];

  @override
  Future<void> identify({
    String? userId,
    Map<String, dynamic>? properties,
  }) async {
    _userId = userId ?? _userId;
    var url = Uri.https(laudspeakerHost, 'customers/upsert');

    var body = json.encode({
      "correlationKey": "externalId",
      "correlationValue": _userId,
      "email": properties?['email']
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Api-Key $_apiKey'
    };
    await _client.post(url, body: body, headers: headers);
  }

  @override
  Future<void> trackEvent(AnalyticsEvent event) async {
    var url = Uri.https(laudspeakerHost, 'events');

    var body = json.encode({
      "correlationKey": "externalId",
      "correlationValue": _userId,
      "event": {
        "name": event.name,
        "properties": event.properties,
      }
    });
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Api-Key $_apiKey'
    };
    await _client.post(url, body: body, headers: headers);
  }

  @override
  Future<void> trackEvents(List<AnalyticsEvent> events) async {
    await Future.forEach<AnalyticsEvent>(events, (event) => trackEvent(event));
  }

  String? getUserId() {
    return _userId;
  }
}
