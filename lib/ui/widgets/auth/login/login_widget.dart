import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/auth/login/login_widget_model.dart';
import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/theme/app_button_style.dart';
import 'package:vk_app/theme/app_colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: const [
              _LoginWidgetBody(),
              SizedBox(height: 16),
              _LoginWidgetFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginWidgetBody extends StatelessWidget {
  const _LoginWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          _LoginWidgetLogo(),
          SizedBox(height: 16),
          _ErrorMessageWidget(),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _LoginWidgetLogo extends StatelessWidget {
  const _LoginWidgetLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.logoBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'VK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Вход ВКонтакте',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<LoginWidgetModel>(context);
    final errorMessage = model?.errorMessage;

    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textFieldErrorText,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () =>
          NotifierProvider.read<LoginWidgetModel>(context)?.auth(context),
      style: AppButtonStyle.blueStyleButton,
      child: const Text(
        'Войти',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _LoginWidgetFooter extends StatelessWidget {
  const _LoginWidgetFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          _ButtonsDivider(),
          SizedBox(height: 16),
          _LoginWithAppleButton(),
        ],
      ),
    );
  }
}

class _LoginWithAppleButton extends StatelessWidget {
  const _LoginWithAppleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () =>
          NotifierProvider.read<LoginWidgetModel>(context)?.loginWithApple(),
      style: AppButtonStyle.whiteStyleButton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.apple,
            size: 36,
          ),
          Text(
            'Войти через Apple',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.apple,
            size: 36,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class _ButtonsDivider extends StatelessWidget {
  const _ButtonsDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'или',
      style: TextStyle(
        fontSize: 14,
        color: AppColors.textFieldHint,
      ),
    );
  }
}
