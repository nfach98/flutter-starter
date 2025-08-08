import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/models/post.dart';
import 'package:starter/widgets/post_item.dart';
import 'package:starter/riverpod/list_notifier.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(listNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('List'),
      ),
      body: state.when(
        data: (posts) => _buildList(posts, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildList(List<Post> posts, WidgetRef ref) {
    if (posts.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(listNotifierProvider.notifier).fetchPosts(),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) => PostItem(
          post: posts[index],
        ),
      ),
    );
  }
}
