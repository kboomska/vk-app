import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vk_app/ui/widgets/loader/loader_view_model.dart';
import 'package:vk_app/ui/widgets/loader/loader_widget.dart';

class ScreenFactory {
  Widget createLoader() {
    return Provider(
      lazy: false,
      create: (context) => LoaderViewModel(context),
      child: const LoaderWidget(),
    );
  }
}
