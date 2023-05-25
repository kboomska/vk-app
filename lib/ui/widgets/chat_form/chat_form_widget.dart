import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vk_app/ui/widgets/chat_form/chat_form_widget_model.dart';
import 'package:vk_app/theme/app_text_field.dart';
import 'package:vk_app/theme/app_colors.dart';

class ChatFormWidget extends StatelessWidget {
  const ChatFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChatFormWidgetBody();
  }
}

class _ChatFormWidgetBody extends StatelessWidget {
  const _ChatFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChatFormWidgetModel>();
    final isValid =
        context.select((ChatFormWidgetModel model) => model.isValid);

    InkWell doneActive = InkWell(
      onTap: () => model.saveChat(context),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Готово',
          style: TextStyle(
            color: AppColors.linkBlue,
          ),
        ),
      ),
    );

    const doneInactive = Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Готово',
        style: TextStyle(
          color: AppColors.closeIcon,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.iconBlue),
        elevation: 0,
        leading: isValid ? doneActive : doneInactive,
        centerTitle: true,
        title: const Text(
          'Начать общение',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => model.closeForm(context),
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.closeIconBackground,
              child: Icon(
                Icons.close,
                size: 18,
                color: AppColors.closeIcon,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: const ColoredBox(
        color: AppColors.appBackgroundColor,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: _ChatNameWidget(),
          ),
        ),
      ),
    );
  }
}

class _ChatNameWidget extends StatelessWidget {
  const _ChatNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChatFormWidgetModel>();
    final errorText =
        context.select((ChatFormWidgetModel model) => model.errorText);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          autofocus: true,
          decoration: AppTextField.inputDecoration(
            hintText: 'Новый чат',
            isError: errorText != null,
          ),
          onEditingComplete: () => model.saveChat(context),
          onChanged: (value) => model.chatName = value,
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
