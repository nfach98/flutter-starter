import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/app/modules/detail/controllers/detail_controller.dart';
import 'package:starter/app/data/models/post.dart';

class DetailScreen extends GetView<DetailController> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail'),
      ),
      body: controller.obx(
        (post) => _buildPostDetail(context, post),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(child: Text('Post not found')),
        onError: (error) => Center(child: Text(error ?? 'Error occurred')),
      ),
    );
  }

  Widget _buildPostDetail(BuildContext context, Post? post) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () => controller.fetchPostDetail(controller.id),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post?.title ?? '',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              post?.body ?? '',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
