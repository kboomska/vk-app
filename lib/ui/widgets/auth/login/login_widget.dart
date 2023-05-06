import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/auth/login/login_widget_model.dart';
import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/theme/app_button_style.dart';
import 'package:vk_app/theme/app_text_field.dart';
import 'package:vk_app/theme/app_colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _model = LoginWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.iconBlue),
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
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
              _HeaderOfLoginWidget(),
              SizedBox(height: 20),
              _FormOfLoginWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderOfLoginWidget extends StatelessWidget {
  const _HeaderOfLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 52,
        ),
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
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _FormOfLoginWidget extends StatelessWidget {
  const _FormOfLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: const [
          _LoginFormWidget(),
          SizedBox(height: 20),
          _LoginButton(),
          Spacer(),
          _SingInButton(),
        ],
      ),
    );
  }
}

class _LoginFormWidget extends StatefulWidget {
  const _LoginFormWidget({super.key});

  @override
  State<_LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<_LoginFormWidget> {
  // final _loginTextController = TextEditingController();
  // final _loginTextController =
  //     TextEditingController(text: 'admin@mail.ru'); // For testing only!

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<LoginWidgetModel>(context);
    final errorText = model?.errorText;
    final loginTextController = model?.loginTextController;

    InkWell suffixIcon = InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        model?.login = '';
        loginTextController?.text = '';
      },
      child: const Icon(
        Icons.highlight_off,
        color: AppColors.textFieldHint,
        size: 16,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: loginTextController,
          style: const TextStyle(
            fontSize: 16,
          ),
          cursorColor: AppColors.logoBlue,
          cursorHeight: 20,
          onChanged: (text) => model?.login = text,
          decoration: AppTextField.inputDecoration(
            hintText: 'Введите почту',
            isError: errorText != null,
            suffixIcon: model?.isLogin == true ? suffixIcon : null,
          ),
          keyboardType: TextInputType.emailAddress,
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

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => NotifierProvider.read<LoginWidgetModel>(context)
          ?.goToPasswordScreen(context),
      style: AppButtonStyle.blueStyleButton,
      child: const Text(
        'Войти',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SingInButton extends StatelessWidget {
  const _SingInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<LoginWidgetModel>(context);

    return OutlinedButton(
      onPressed: () => model?.auth(context),
      style: AppButtonStyle.greenStyleButton,
      child: const Text(
        'Зарегистрироваться',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
