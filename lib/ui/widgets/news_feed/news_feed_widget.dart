import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vk_app/ui/widgets/news_feed/news_feed_view_model.dart';
import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/theme/app_colors.dart';

class NewsFeedWidget extends StatefulWidget {
  const NewsFeedWidget({super.key});

  @override
  State<NewsFeedWidget> createState() => _NewsFeedWidgetState();
}

class _NewsFeedWidgetState extends State<NewsFeedWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<NewsFeedViewModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: const IconThemeData(color: AppColors.iconBlue),
        elevation: 1,
        shadowColor: AppColors.mainAppBarShadowColor,
        title: const Text(
          'Главная',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => AccessDataProvider().setAccessToken(null),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const ColoredBox(
        color: AppColors.mainBackgroundColor,
        child: _PostListWidget(),
      ),
    );
  }
}

class _PostListWidget extends StatelessWidget {
  const _PostListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewsFeedViewModel>();

    return ListView.separated(
      itemCount: model.posts.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemBuilder: (context, index) {
        model.fetchPostsAtIndex(index);
        return _PostCardWidget(index: index);
      },
    );
  }
}

class _PostCardWidget extends StatelessWidget {
  final int index;

  const _PostCardWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsFeedViewModel>();
    final post = model.posts[index];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostCardHeaderWidget(
            author: post.sourceName,
            avatar: post.sourcePhoto,
            date: post.postDate,
          ),
          _PostCardTextWidget(text: post.postText),
          _PostCardMediaWidget(attachment: post.postAttachment),
          _PostCardFooterWidget(
            index: index,
          ),
        ],
      ),
    );
  }
}

class _PostCardHeaderWidget extends StatelessWidget {
  final String avatar;
  final String author;
  final String date;

  const _PostCardHeaderWidget({
    super.key,
    required this.avatar,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(avatar),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.postAuthor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.postTextSubtitle,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            iconSize: 24,
            constraints: BoxConstraints.tight(const Size(40, 40)),
            icon: const Icon(
              Icons.more_horiz,
              color: AppColors.postActions,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostCardTextWidget extends StatelessWidget {
  final String text;

  const _PostCardTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
      child: Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.postAuthor,
        ),
      ),
    );
  }
}

class _PostCardMediaWidget extends StatelessWidget {
  final String attachment;

  const _PostCardMediaWidget({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    Widget setAttachment(String attachment) {
      if (attachment.isNotEmpty) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 510),
            child: Image.network(attachment),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: setAttachment(attachment),
    );
  }
}

class _PostCardFooterWidget extends StatelessWidget {
  final int index;

  const _PostCardFooterWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsFeedViewModel>();
    final post = model.posts[index];
    final views = post.views;

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        children: [
          _PostCardLikeButton(
            index: index,
          ),
          const SizedBox(
            width: 8,
          ),
          _PostCardBottomButton(
            buttonCounter: post.comments,
            buttonIcon: const Icon(
              Icons.messenger_outline_outlined,
              color: AppColors.postBottomButtons,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          _PostCardBottomButton(
            buttonCounter: post.reposts,
            buttonIcon: const Icon(
              Icons.reply_rounded,
              color: AppColors.postBottomButtons,
              size: 24,
              textDirection: TextDirection.rtl,
            ),
          ),
          const Spacer(),
          if (views != null)
            Row(
              children: [
                const Icon(
                  Icons.visibility,
                  color: AppColors.postBottomViews,
                  size: 16,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  views,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.postBottomViews,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class _PostCardLikeButton extends StatelessWidget {
  final int index;

  const _PostCardLikeButton({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewsFeedViewModel>();
    final post = model.posts[index];

    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => model.onTapLikeButton(index: index),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            color: post.userLikes
                ? AppColors.postLikedButtonBackground
                : AppColors.postBottomButtonsBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(
                  Icons.favorite_outline,
                  color: post.userLikes
                      ? AppColors.postLikedButton
                      : AppColors.postBottomButtons,
                  size: 24,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  post.likes,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: post.userLikes
                        ? AppColors.postLikedButton
                        : AppColors.postBottomButtons,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostCardBottomButton extends StatelessWidget {
  final String buttonCounter;
  final Icon buttonIcon;

  const _PostCardBottomButton({
    super.key,
    required this.buttonCounter,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.postBottomButtonsBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(
              width: 4,
            ),
            Text(
              buttonCounter,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.postBottomButtons,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
