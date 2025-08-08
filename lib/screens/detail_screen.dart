import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/riverpod/detail_notifier.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(detailNotifierProvider.notifier).fetchPostDetail(widget.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail'),
      ),
      body: _buildPostDetail(),
    );
  }

  Widget _buildPostDetail() {
    final theme = Theme.of(context);
    final value = ref.watch(detailNotifierProvider);
    final notifier = ref.read(detailNotifierProvider.notifier);

    return value.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => const Center(
        child: Text('Post not found'),
      ),
      data: (post) {
        if (post == null) {
          return const Center(
            child: Text('Post not found'),
          );
        }

        return RefreshIndicator(
          onRefresh: () => notifier.fetchPostDetail(widget.id ?? 0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title ?? 'No Title',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  post.body ?? 'No Content',
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
