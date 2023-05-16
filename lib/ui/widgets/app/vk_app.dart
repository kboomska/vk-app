import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/ui/widgets/app/vk_app_model.dart';

class VKApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const VKApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<VKAppModel>(context);

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
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
