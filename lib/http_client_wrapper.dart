import 'package:flutter_app_analytics_laudspeaker_provider/http_client_wrapper_interface.dart';
import 'package:http/http.dart';

class HttpClientWrapper implements HttpClientWrapperInterface {
  final Client _client = Client();

  @override
  Future<void> post(Uri uri, {Map<String, String>? headers, dynamic body}) {
    return _client.post(uri, headers: headers, body: body);
  }
}
