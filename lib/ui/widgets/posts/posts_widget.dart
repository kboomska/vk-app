import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/posts/posts_widget_model.dart';
import 'package:vk_app/theme/app_colors.dart';

class PostsWidget extends StatefulWidget {
  const PostsWidget({super.key});

  @override
  State<PostsWidget> createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  final model = PostsWidgetModel();

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
      ),
      body: PostsWidgetModelProvider(
        model: model,
        child: const ColoredBox(
          color: AppColors.mainBackgroundColor,
          child: _PostListWidget(),
        ),
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
    print('PostList build');
    return ListView.separated(
      itemCount: PostsWidgetModelProvider.noticeOf(context)?.posts.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemBuilder: (context, index) {
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
    final post = PostsWidgetModelProvider.readOnly(context)!.posts[index];

    print('PostCard build: $index');
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          _PostCardHeaderWidget(
            avatar: post.avatar,
            author: post.author,
            date: post.date,
          ),
          _PostCardTextWidget(text: post.text),
          _PostCardMediaWidget(media: post.media),
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
    print('PostHeader build');
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
            child: Image.asset(
              avatar,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            children: [
              Text(
                author,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.postAuthor,
                ),
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
            onPressed: () {
              print('Post actions');
            },
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
    print('PostText build');
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
  final String media;

  const _PostCardMediaWidget({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    print('PostMedia build');
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Image.asset(
        media,
      ),
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
    final post = PostsWidgetModelProvider.readOnly(context)!.posts[index];
    print('PostFooter build');
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
            buttonCounter: post.replies,
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
            buttonCounter: post.share,
            buttonIcon: const Icon(
              Icons.reply_rounded,
              color: AppColors.postBottomButtons,
              size: 24,
              textDirection: TextDirection.rtl,
            ),
          ),
          const Spacer(),
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
                post.views,
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
    final post = PostsWidgetModelProvider.readOnly(context)!.posts[index];
    final int reactions = post.reactions;
    final bool isLiked = post.isLiked;

    print('PostLikeButton build');
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => PostsWidgetModelProvider.noticeOf(context)
            ?.onTapLikeButton(index: index),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            color: isLiked
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
                  color: isLiked
                      ? AppColors.postLikedButton
                      : AppColors.postBottomButtons,
                  size: 24,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '$reactions',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isLiked
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
  final int buttonCounter;
  final Icon buttonIcon;

  const _PostCardBottomButton({
    super.key,
    required this.buttonCounter,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    print('PostBottomButton build');
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
              '$buttonCounter',
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
