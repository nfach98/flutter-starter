import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/providers/list_provider.dart';
import 'package:starter/router/app_router.dart';
import 'package:starter/widgets/post_item.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<ListProvider>(
      create: (_) => getIt<ListProvider>()..getPosts(),
      builder: (_, __) => Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text('List'),
          actions: [
            Consumer<ListProvider>(
              builder: (_, provider, __) => IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  provider.logout();
                  Navigator.pushReplacementNamed(context, AppRouter.login);
                },
              ),
            ),
          ],
        ),
        body: const _ListScreenBody(),
      ),
    );
  }
}

class _ListScreenBody extends StatelessWidget {
  const _ListScreenBody();

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (_, provider, __) {
        final isLoading = provider.isLoading;
        final posts = provider.posts;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (posts.isEmpty) {
          return const Center(child: Text('No todos found'));
        }

        return RefreshIndicator(
          onRefresh: () => provider.getPosts(),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) => PostItem(
              post: posts[index],
            ),
          ),
        );
      },
    );
  }
}
