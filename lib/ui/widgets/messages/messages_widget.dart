import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:vk_app/ui/widgets/message_form/message_form_widget.dart';
import 'package:vk_app/ui/widgets/messages/messages_widget_model.dart';
import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/theme/app_colors.dart';

class MessagesWidgetConfiguration {
  final int chatKey;
  final String title;

  MessagesWidgetConfiguration(this.chatKey, this.title);
}

class MessagesWidget extends StatefulWidget {
  final MessagesWidgetConfiguration configuration;

  const MessagesWidget({super.key, required this.configuration});

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  late MessagesWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = MessagesWidgetModel(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      model: _model,
      child: const _MessagesWidgetBody(),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}

class _MessagesWidgetBody extends StatelessWidget {
  const _MessagesWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MessagesWidgetModel>(context);
    final chatName = model?.configuration.title ?? 'DELETED';
    final chatKey = model?.configuration.chatKey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.iconBlue),
        elevation: 0,
        title: Text(
          chatName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              print('Search message');
            },
            child: const Icon(
              Icons.search,
              color: AppColors.chatActionIcon,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: ColoredBox(
        color: AppColors.appBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const _MessagesListWidget(),
            MessageFormWidget(chatKey: chatKey),
          ],
        ),
      ),
    );
  }
}

class _MessagesListWidget extends StatelessWidget {
  const _MessagesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final messagesCount =
        NotifierProvider.watch<MessagesWidgetModel>(context)?.messages.length ??
            0;

    return Flexible(
      child: ListView.builder(
        reverse: true,
        primary: false,
        itemCount: messagesCount,
        itemBuilder: (context, index) {
          return _MessageBubbleWidget(indexInList: index);
        },
      ),
    );
  }
}

class _MessageBubbleWidget extends StatelessWidget {
  final int indexInList;
  const _MessageBubbleWidget({
    super.key,
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MessagesWidgetModel>(context)!;
    final message = model.messages[indexInList];
    final time = message.time.toIso8601String().split(RegExp(r'[T:]'));
    final timeString = '${time[1]}:${time[2]}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => model.deleteMessage(indexInList),
              backgroundColor: AppColors.appBackgroundColor,
              foregroundColor: AppColors.chatDeleteAction,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: AppColors.messageBubbleBackground,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${message.text}  ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: timeString,
                            style: const TextStyle(
                              color: Colors.transparent,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 5,
                    child: Text(
                      timeString,
                      style: const TextStyle(
                        color: AppColors.messageBubbleTimeText,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
