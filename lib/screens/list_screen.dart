import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bloc/list/list_bloc.dart';
import 'package:starter/bloc/list/list_event.dart';
import 'package:starter/bloc/list/list_state.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/widgets/post_item.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<ListBloc>();
        bloc.add(GetPosts());

        return bloc;
      },
      child: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          final theme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.colorScheme.inversePrimary,
              title: const Text('List'),
            ),
            body: _buildList(
              context: context,
              state: state,
            ),
          );
        },
      ),
    );
  }

  Widget _buildList({
    required BuildContext context,
    required ListState state,
  }) {
    final isLoading = state.isLoading;
    final posts = state.posts;

    final bloc = BlocProvider.of<ListBloc>(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (posts.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return RefreshIndicator(
      onRefresh: () async => bloc.add(GetPosts()),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) => PostItem(
          post: posts[index],
        ),
      ),
    );
  }
}
