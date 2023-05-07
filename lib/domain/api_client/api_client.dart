import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/ui/widgets/auth/web_page/web_page.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';

class ApiClient {
  final _client = HttpClient();
  final _accessDataProvider = AccessDataProvider();

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

  Map<String, dynamic> getResponseFragments(String response) {
    Map<String, dynamic> authResponse = {};
    final responseUri = Uri.parse(response);
    final uriFragments = responseUri.fragment.split('&');
    for (var element in uriFragments) {
      authResponse[element.split('=')[0]] = element.split('=')[1];
    }

    return authResponse;
  }

  Future<String?> auth(BuildContext context, String clientId) async {
    String? response;

    final parameters = <String, dynamic>{
      'client_id': clientId,
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

    final configuration = WebPageConfiguration(
      authorizationUri,
      _redirectUri,
    );

    await Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.oauth, arguments: configuration)
        .then((value) => response = value as String?);

    return response;
  }

  Future<dynamic> getNewsFeed() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    parser(dynamic json) {
      return json;
    }

    final parameters = <String, dynamic>{
      'filters': 'post',
      'access_token': accessToken,
      'v': _versionApi,
    };

    final url = _makeUri(
      _host,
      '/newsfeed.get',
      parameters,
    );

    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    // request.write(jsonEncode(object));
    final response = await request.close();
    final json = await response.jsonDecode();
    final result = parser(json);
    return result;
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
