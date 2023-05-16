import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/ui/widgets/app/vk_app_model.dart';
import 'package:vk_app/ui/widgets/app/vk_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final model = VKAppModel();
  await model.checkAuth();

  const app = VKApp();
  final widget = Provider(
    model: model,
    child: app,
  );

  runApp(widget);
}
