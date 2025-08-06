import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/router/app_router.gr.dart';

@RoutePage()
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _postRepository = PostRepository();
  final _posts = <Post>[];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('List'),
      ),
      body: _buildList(),
    );
  }

  Future<void> _getPosts() async {
    setState(() => _isLoading = true);
    final result = await _postRepository.getPosts();
    setState(() {
      _isLoading = false;
      _posts.clear();
      _posts.addAll(result);
    });
  }

  Widget _buildList() {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_posts.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return RefreshIndicator(
      onRefresh: () => _getPosts(),
      child: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final todo = _posts[index];

          return ListTile(
            title: Text(
              todo.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              todo.body ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
            onTap: () {
              context.pushRoute(const DetailRoute());
            },
          );
        },
      ),
    );
  }
}
