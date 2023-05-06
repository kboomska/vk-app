import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/auth/password/password_widget_model.dart';
import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/theme/app_button_style.dart';
import 'package:vk_app/theme/app_text_field.dart';
import 'package:vk_app/theme/app_colors.dart';
import 'package:vk_app/theme/icon_id.dart';

class PasswordWidget extends StatefulWidget {
  final String login;

  const PasswordWidget({super.key, required this.login});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  late PasswordWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = PasswordWidgetModel(login: widget.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.iconBlue),
        centerTitle: true,
        elevation: 0.0,
        title: IconID.small,
      ),
      backgroundColor: AppColors.appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: NotifierProvider(
          model: _model,
          child: Column(
            children: const [
              _HeaderOfPasswordWidget(),
              SizedBox(height: 20),
              _FormOfPasswordWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderOfPasswordWidget extends StatelessWidget {
  const _HeaderOfPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<PasswordWidgetModel>(context)!;

    return Column(
      children: [
        const Text(
          'Введите пароль',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Укажите пароль, привязанный к почте',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textFieldHint,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        FittedBox(
          child: Text(
            model.login,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class _FormOfPasswordWidget extends StatelessWidget {
  const _FormOfPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _PasswordFormWidget(),
          _ForgottenPasswordButton(),
          Spacer(),
          _ContinueButton(),
        ],
      ),
    );
  }
}

class _PasswordFormWidget extends StatefulWidget {
  const _PasswordFormWidget({super.key});

  @override
  State<_PasswordFormWidget> createState() => _PasswordFormWidgetState();
}

class _PasswordFormWidgetState extends State<_PasswordFormWidget> {
  // final _passwordTextController = TextEditingController();
  final _passwordTextController =
      TextEditingController(text: 'admin'); // For testing only!

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<PasswordWidgetModel>(context);
    final errorText = model?.errorText;

    InkWell suffixIcon = InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        model?.obscureText();
      },
      child: model?.isObscure == true
          ? const Icon(
              Icons.visibility,
              color: AppColors.textFieldHint,
              size: 16,
            )
          : const Icon(
              Icons.visibility_off,
              color: AppColors.textFieldHint,
              size: 16,
            ),
    );

    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: TextField(
            controller: _passwordTextController,
            style: const TextStyle(
              fontSize: 16,
            ),
            cursorColor: AppColors.logoBlue,
            cursorHeight: 20,
            obscureText: model?.isObscure == true,
            onChanged: (text) => model?.password = text,
            decoration: AppTextField.inputDecoration(
              hintText: 'Введите пароль',
              isError: errorText != null,
              suffixIcon: model?.isPassword == true ? suffixIcon : null,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(
            height: 8,
          ),
          Text(
            errorText,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textFieldErrorText,
            ),
          ),
        ],
      ],
    );
  }
}

class _ForgottenPasswordButton extends StatelessWidget {
  const _ForgottenPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: NotifierProvider.read<PasswordWidgetModel>(context)
          ?.forgottenPassword,
      style: AppButtonStyle.linkStyleButton,
      child: const Text(
        'Забыли или не установили пароль?',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<PasswordWidgetModel>(context);

    return OutlinedButton(
      onPressed: model?.isPassword == true
          ? () => model?.goToHomeScreen(context)
          : null,
      style: AppButtonStyle.blueStyleDeactivableButton(
        isActive: model?.isPassword == true,
      ),
      child: const Text(
        'Продолжить',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
