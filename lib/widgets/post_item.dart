import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/models/post.dart';
import 'package:starter/router/app_router.gr.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, this.post});

  final Post? post;

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
        context.pushRoute(
          DetailRoute(id: post?.id ?? 0),
        );
      },
    );
  }
}
