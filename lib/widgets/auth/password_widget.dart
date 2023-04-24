import 'package:flutter/material.dart';

import '/widgets/provider/password_widget_provider.dart';
import '/theme/app_button_style.dart';
import '/theme/app_text_field.dart';
import '/theme/app_colors.dart';
import '/theme/icon_id.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  final _model = PasswordWidgetModel();

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
        child: PasswordWidgetModelProvider(
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
    final String login = ModalRoute.of(context)!.settings.arguments as String;

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
            login,
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

class _FormOfPasswordWidget extends StatefulWidget {
  const _FormOfPasswordWidget({super.key});

  @override
  State<_FormOfPasswordWidget> createState() => __FormOfPasswordWidgetState();
}

class __FormOfPasswordWidgetState extends State<_FormOfPasswordWidget> {
  // final _passwordTextController = TextEditingController();
  final _passwordTextController =
      TextEditingController(text: 'admin'); // For testing only!

  @override
  Widget build(BuildContext context) {
    final errorText =
        PasswordWidgetModelProvider.noticeOf(context)?.model.errorText;
    final isError =
        PasswordWidgetModelProvider.readOnly(context)?.model.isError ?? false;
    bool isObscure =
        PasswordWidgetModelProvider.readOnly(context)?.model.isObscure ?? true;
    final isContinue =
        PasswordWidgetModelProvider.readOnly(context)?.model.isContinue ??
            false;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              obscureText: isObscure,
              onChanged: (text) => PasswordWidgetModelProvider.readOnly(context)
                  ?.model
                  .password = text,
              decoration: AppTextField.inputDecoration(
                hintText: 'Введите пароль',
                isError: isError,
                suffixIcon: PasswordWidgetModelProvider.readOnly(context)
                            ?.model
                            .password ==
                        ''
                    ? null
                    : InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          PasswordWidgetModelProvider.readOnly(context)
                              ?.model
                              .obscureText();
                        },
                        child: isObscure
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
                      ),
              ),
            ),
          ),
          if (errorText != null && isError) ...[
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
          TextButton(
            onPressed: PasswordWidgetModelProvider.readOnly(context)
                ?.model
                .forgottenPassword,
            style: AppButtonStyle.linkStyleButton,
            child: const Text(
              'Забыли или не установили пароль?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: isContinue
                ? () => PasswordWidgetModelProvider.readOnly(context)
                    ?.model
                    .goToHomeScreen(context)
                : null,
            style: AppButtonStyle.blueStyleDeactivableButton(
              isActive: isContinue,
            ),
            child: const Text(
              'Продолжить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
