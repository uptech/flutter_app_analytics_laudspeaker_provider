abstract class HttpClientWrapperInterface {
  Future<void> post(Uri uri, {Map<String, String>? headers, dynamic body});
}
