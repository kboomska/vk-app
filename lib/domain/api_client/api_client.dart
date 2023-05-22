import 'dart:io';

import 'package:flutter/material.dart';

import 'package:vk_app/domain/entity/news_feed/posts/news_feed_response.dart';
import 'package:vk_app/ui/widgets/auth/oauth_web_page/oauth_web_page.dart';
import 'package:vk_app/domain/entity/news_feed/posts/json_response.dart';
import 'package:vk_app/domain/api_client/api_client_exception.dart';
import 'package:vk_app/domain/api_client/network_client.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/configuration/configuration.dart';

class ApiClient {
  final _networkClient = NetworkClient();

  Future<String> auth(BuildContext context) async {
    late String accessToken;

    final parameters = <String, dynamic>{
      'client_id': Configuration.clientId,
      'redirect_uri': Configuration.redirectUri,
      'display': Configuration.display,
      'scope': Configuration.scope,
      'response_type': Configuration.responseType,
      'lang': Configuration.language,
    };

    final authorizationUri = _networkClient.makeUri(
      Configuration.authHost,
      '/authorize',
      parameters,
    );

    final configuration = OAuthWebPageConfiguration(
      authorizationUri,
      Configuration.redirectUri,
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
      'v': Configuration.versionApi,
    };

    final result = _networkClient.post(
      '/newsfeed.get',
      parser,
      parameters,
    );

    return result;
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
