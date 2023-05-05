import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vk_app/ui/widgets/auth/web_page/web_page.dart';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://oauth.vk.com';
  static const _redirectUri = 'https://oauth.vk.com/blank.html';
  static const _display = 'mobile';
  static const _scope = '1026';
  static const _responseType = 'token';
  static const _language = 'ru';

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
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

  Future<String> auth(BuildContext context, String clientId) async {
    String response = '';

    final parameters = <String, dynamic>{
      'client_id': clientId,
      'redirect_uri': _redirectUri,
      'display': _display,
      'scope': _scope,
      'response_type': _responseType,
      'lang': _language,
    };

    final authorizationUri = _makeUri(
      '/authorize',
      parameters,
    );

    // print(authorizationUri);

    await Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => WebPageWidget(
                  uri: authorizationUri,
                  tokenEndpoint: _redirectUri,
                )))
        .then((value) {
      if (value != null) {
        response = value;
      }
    });

    return response;
  }
}
