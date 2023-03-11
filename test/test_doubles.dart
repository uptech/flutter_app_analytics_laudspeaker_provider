import 'package:flutter_app_analytics_laudspeaker_provider/http_client_wrapper_interface.dart';

class PostSpy {
  Uri? uri;
  Map<String, dynamic>? headers;
  dynamic body;
  PostSpy(this.uri, this.headers, this.body);
}

class ClientTestDouble implements HttpClientWrapperInterface {
  List<PostSpy> posts = [];

  @override
  Future<void> post(Uri uri,
      {Map<String, String>? headers, dynamic body}) async {
    posts.add(PostSpy(uri, headers, body));
    return Future.value(null);
  }
}
