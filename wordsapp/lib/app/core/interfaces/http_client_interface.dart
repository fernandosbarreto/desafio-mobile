import 'package:dio/dio.dart';

abstract class IHttpClient {
  Future get(String? url,
      {Map<String, dynamic>? queryParameters, Options? options});
  Future post(String url, {dynamic data, Options? options});
  Future put(String url, {dynamic data, Options? options});
  Future delete(String url, {dynamic data, Options? options});
}
