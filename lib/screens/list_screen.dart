import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/widgets/post_item.dart';

@RoutePage()
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
    final result = await getIt<PostRepository>().getPosts();
    setState(() {
      _isLoading = false;
      _posts.clear();
      _posts.addAll(result);
    });
  }

  Widget _buildList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_posts.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return RefreshIndicator(
      onRefresh: () => _getPosts(),
      child: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (_, index) => PostItem(
          post: _posts[index],
        ),
      ),
    );
  }
}
