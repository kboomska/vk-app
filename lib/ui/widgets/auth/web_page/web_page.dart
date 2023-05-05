import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:vk_app/theme/app_colors.dart';

class WebPageWidget extends StatefulWidget {
  final Uri uri;
  final String tokenEndpoint;

  const WebPageWidget({
    super.key,
    required this.uri,
    required this.tokenEndpoint,
  });

  @override
  State<WebPageWidget> createState() => _WebPageWidgetState();
}

class _WebPageWidgetState extends State<WebPageWidget> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    Future<void> backToLoginScreen(
      BuildContext context, {
      String response = '',
    }) async {
      await WebViewCookieManager().clearCookies();
      await controller.clearLocalStorage();

      Navigator.of(context).pop(response);
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith(widget.tokenEndpoint)) {
              await backToLoginScreen(context, response: request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.uri);

    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
        } else {
          print('Нет записи в истории');
          await backToLoginScreen(context);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Вход ВКонтакте',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appBackgroundColor,
          iconTheme: const IconThemeData(color: AppColors.iconBlue),
          elevation: 1,
          shadowColor: AppColors.mainAppBarShadowColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () => controller.reload(),
            ),
          ],
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
