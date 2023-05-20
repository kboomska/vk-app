import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:vk_app/ui/navigation/main_navigation.dart';

class VKApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const VKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VK App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en'),
        Locale('ru', 'RU'),
      ],
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.loader,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
