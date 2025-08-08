import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/providers/detail_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => getIt<DetailProvider>()..getPostDetail(id ?? 0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text('Detail'),
        ),
        body: _DetailPost(id),
      ),
    );
  }
}

class _DetailPost extends StatelessWidget {
  final int? id;

  const _DetailPost(this.id);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DetailProvider>();

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (provider.post == null) {
      return const Center(
        child: Text('Post not found'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.getPostDetail(id ?? 0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.post?.title ?? '',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              provider.post?.body ?? '',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
