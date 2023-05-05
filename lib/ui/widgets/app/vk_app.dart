import 'package:flutter/material.dart';

import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/ui/widgets/app/vk_app_model.dart';

class VKApp extends StatelessWidget {
  final VKAppModel model;
  static final mainNavigation = MainNavigation();

  const VKApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VK App',
      debugShowCheckedModeBanner: false,
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
