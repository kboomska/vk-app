import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:vk_app/ui/widgets/messages/messages_widget_model.dart';
import 'package:vk_app/domain/factories/screen_factory.dart';
import 'package:vk_app/theme/app_colors.dart';

class MessagesWidgetConfiguration {
  final int chatKey;
  final String title;

  MessagesWidgetConfiguration(this.chatKey, this.title);
}

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MessagesWidgetBody();
  }
}

class _MessagesWidgetBody extends StatelessWidget {
  const _MessagesWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenFactory = ScreenFactory();
    final configuration =
        context.select((MessagesWidgetModel model) => model.configuration);
    final chatName = configuration.title;
    final chatKey = configuration.chatKey;

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
            screenFactory.createMessageForm(chatKey),
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
        context.select((MessagesWidgetModel model) => model.messages.length);

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
    final model = context.read<MessagesWidgetModel>();
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
