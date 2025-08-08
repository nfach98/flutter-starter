import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/app/data/models/post.dart';
import 'package:starter/app/routes/app_pages.dart';

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
        Get.toNamed(
          Routes.DETAIL,
          arguments: post?.id,
        );
      },
    );
  }
}
