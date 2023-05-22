import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:vk_app/domain/entity/news_feed/posts/news_feed_response.dart';
import 'package:vk_app/ui/widgets/auth/oauth_web_page/oauth_web_page.dart';
import 'package:vk_app/domain/entity/news_feed/posts/json_response.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';

enum ApiClientExceptionType { network, authCancel, accessToken, captcha, other }

class ApiClientException implements Exception {
  ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  static const _clientId = String.fromEnvironment('CLIENT_ID');
  static const _authHost = 'https://oauth.vk.com';
  static const _host = 'https://api.vk.com/method';
  static const _redirectUri = 'https://oauth.vk.com/blank.html';
  static const _display = 'mobile';
  static const _scope = '9218';
  static const _responseType = 'token';
  static const _versionApi = '5.131';
  static const _language = 'ru';

  Uri _makeUri(String host, String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> auth(BuildContext context) async {
    late String accessToken;

    final parameters = <String, dynamic>{
      'client_id': _clientId,
      'redirect_uri': _redirectUri,
      'display': _display,
      'scope': _scope,
      'response_type': _responseType,
      'lang': _language,
    };

    final authorizationUri = _makeUri(
      _authHost,
      '/authorize',
      parameters,
    );

    // print(authorizationUri);

    final configuration = OAuthWebPageConfiguration(
      authorizationUri,
      _redirectUri,
    );

    try {
      await Navigator.of(context)
          .pushNamed(MainNavigationRouteNames.oauth, arguments: configuration)
          .then((value) => accessToken = _checkAuthResponse(value));

      return accessToken;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> urlParameters,
  ) async {
    final url = _makeUri(
      _host,
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

  Future<NewsFeedResponse> getNewsFeed(
      String? accessToken, String? startFrom) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final jsonResponse = JsonResponse.fromJson(jsonMap);
      return jsonResponse.response;
    }

    final parameters = <String, dynamic>{
      'filters': 'post',
      'start_from': startFrom,
      'access_token': accessToken,
      'v': _versionApi,
    };

    final result = _post(
      '/newsfeed.get',
      parser,
      parameters,
    );

    return result;
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

  String _checkAuthResponse(Object? response) {
    final Map<String, dynamic> authResponse = {};

    if (response != null) {
      final responseString = response as String;
      final responseUri = Uri.parse(responseString);
      final uriFragments = responseUri.fragment.split('&');
      for (var element in uriFragments) {
        authResponse[element.split('=')[0]] = element.split('=')[1];
      }
    }

    if (authResponse.isEmpty || authResponse.containsKey('error')) {
      throw ApiClientException(ApiClientExceptionType.authCancel);
    } else {
      return authResponse['access_token'];
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
