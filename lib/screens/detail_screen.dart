import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/bloc/detail/detail_bloc.dart';
import 'package:starter/bloc/detail/detail_event.dart';
import 'package:starter/bloc/detail/detail_state.dart';
import 'package:starter/injection/injection.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = Injection.detailBloc;
        bloc.add(GetPostDetail(id ?? 0));

        return bloc;
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          final theme = Theme.of(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.colorScheme.inversePrimary,
              title: const Text('Detail'),
            ),
            body: _buildPostDetail(
              context: context,
              state: state,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostDetail({
    required BuildContext context,
    required DetailState state,
  }) {
    final theme = Theme.of(context);
    final bloc = BlocProvider.of<DetailBloc>(context);
    final isLoading = state.isLoading;
    final post = state.post;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (post == null) {
      return const Center(
        child: Text('Post not found'),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => bloc.add(
        GetPostDetail(post.id ?? 0),
      ),
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
  }
}
