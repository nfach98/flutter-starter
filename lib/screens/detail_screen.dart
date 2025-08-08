import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/riverpod/detail_notifier.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail'),
      ),
      body: _buildPostDetail(context, ref),
    );
  }

  Widget _buildPostDetail(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(detailNotifierProvider(id ?? 0));
    final notifier = ref.read(detailNotifierProvider(id ?? 0).notifier);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
      data: (post) {
        if (post == null) {
          return const Center(
            child: Text('Post not found'),
          );
        }

        return RefreshIndicator(
          onRefresh: () => notifier.fetchPostDetail(id ?? 0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title ?? '',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  post.body ?? '',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
