import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:vk_app/theme/app_colors.dart';

class WebPageWidget extends StatelessWidget {
  final Uri uri;
  final String tokenEndpoint;

  const WebPageWidget({
    super.key,
    required this.uri,
    required this.tokenEndpoint,
  });

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(tokenEndpoint)) {
              var response = Uri.parse(request.url);
              Navigator.of(context).pop(response.toString());
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(uri);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Вход в ВК',
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
    );
  }
}
