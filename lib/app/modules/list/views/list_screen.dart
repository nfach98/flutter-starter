import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/app/modules/list/controllers/list_controller.dart';
import 'package:starter/app/modules/list/views/widgets/post_item.dart';

class ListScreen extends GetView<ListController> {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('List'),
      ),
      body: controller.obx(
        (posts) => RefreshIndicator(
          onRefresh: controller.getPosts,
          child: ListView.builder(
            itemCount: posts?.length ?? 0,
            itemBuilder: (_, index) => PostItem(post: posts?[index]),
          ),
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(child: Text('No posts found')),
        onError: (error) => Center(child: Text(error ?? 'Error loading posts')),
      ),
    );
  }
}
