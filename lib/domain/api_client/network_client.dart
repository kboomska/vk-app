import 'dart:convert';
import 'dart:io';

import 'package:vk_app/domain/api_client/api_client_exception.dart';
import 'package:vk_app/configuration/configuration.dart';

class NetworkClient {
  final _client = HttpClient();

  Uri makeUri(String host, String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> post<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> urlParameters,
  ) async {
    final url = makeUri(
      Configuration.host,
      path,
      urlParameters,
    );

    try {
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      final response = await request.close();
      final json = await response.jsonDecode();
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 200) {
      final jsonMap = json as Map<String, dynamic>;
      if (jsonMap.containsKey('error')) {
        final errorCode = jsonMap['error']['error_code'];
        if (errorCode == 5) {
          throw ApiClientException(ApiClientExceptionType.accessToken);
        } else if (errorCode == 14) {
          throw ApiClientException(ApiClientExceptionType.captcha);
        } else {
          throw ApiClientException(ApiClientExceptionType.other);
        }
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((jsonStrings) {
      final result = jsonStrings.join();
      return result;
    }).then((jsonString) => json.decode(jsonString));
  }
}
