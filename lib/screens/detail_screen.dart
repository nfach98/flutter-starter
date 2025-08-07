import 'package:flutter/material.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Post? _post;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPostDetail();
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

  Future<void> _getPostDetail() async {
    setState(() => _isLoading = true);
    final result = await PostRepository.getPostDetail(widget.id ?? 0);
    setState(() {
      _isLoading = false;
      _post = result;
    });
  }

  Widget _buildPostDetail() {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_post == null) {
      return const Center(
        child: Text('Post not found'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _getPostDetail(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _post?.title ?? '',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              _post?.body ?? '',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
