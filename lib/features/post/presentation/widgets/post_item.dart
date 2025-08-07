import 'package:flutter/material.dart';
import 'package:starter/features/post/data/models/post_model.dart';
import 'package:starter/router/app_router.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, this.post});

  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        post?.title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        post?.body ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.detail,
          arguments: post?.id,
        );
      },
    );
  }
}
