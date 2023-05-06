import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:vk_app/ui/widgets/chats/chats_widget_model.dart';
import 'package:vk_app/Library/Widgets/Inherited/provider.dart';
import 'package:vk_app/resources/resources.dart';
import 'package:vk_app/theme/app_colors.dart';

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({super.key});

  @override
  State<ChatsWidget> createState() => _ChatsWidgetState();
}

class _ChatsWidgetState extends State<ChatsWidget> {
  final _model = ChatsWidgetModel();

  @override
  Widget build(BuildContext context) {
    return NotifierProvider(
      model: _model,
      child: const _ChatsWidgetBody(),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}

class _ChatsWidgetBody extends StatelessWidget {
  const _ChatsWidgetBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.iconBlue),
        elevation: 1,
        shadowColor: AppColors.mainAppBarShadowColor,
        title: const Text(
          'Мессенджер',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [_ChatsActionsWidget()],
      ),
      body: const ColoredBox(
        color: AppColors.appBackgroundColor,
        child: _ChatListWidget(),
      ),
    );
  }
}

class _ChatsActionsWidget extends StatelessWidget {
  const _ChatsActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print('Add a new contact');
          },
          child: const Icon(
            Icons.add_call,
            color: AppColors.chatActionIcon,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => NotifierProvider.read<ChatsWidgetModel>(context)
              ?.showForm(context),
          child: const Icon(
            Icons.create,
            color: AppColors.chatActionIcon,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class _ChatListWidget extends StatelessWidget {
  const _ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chatsCount =
        NotifierProvider.watch<ChatsWidgetModel>(context)?.chats.length ?? 0;

    return ListView.builder(
      itemCount: chatsCount,
      itemBuilder: (context, index) {
        return _ChatsListRowWidget(indexInList: index);
      },
    );
  }
}

class _ChatsListRowWidget extends StatelessWidget {
  final int indexInList;
  const _ChatsListRowWidget({
    super.key,
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<ChatsWidgetModel>(context)!;
    final chat = model.chats[indexInList];

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => model.deleteChat(indexInList),
            backgroundColor: AppColors.chatDeleteAction,
            foregroundColor: AppColors.appBackgroundColor,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () => model.showMessages(context, indexInList),
        child: SizedBox(
          height: 75,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(AppImages.chatAvatar),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: AppColors.postTextTitle,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Last message from user',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: AppColors.chatTextSubtitle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
