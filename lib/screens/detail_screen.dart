import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_hex/class/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/providers/detail_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => getIt<DetailProvider>()..getPostDetail(id ?? 0),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: _DetailAppBar(),
        ),
        body: _DetailBody(id),
      ),
    );
  }
}

class _DetailAppBar extends StatelessWidget {
  const _DetailAppBar();

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (_, provider, __) {
        final theme = Theme.of(context);
        final photo = provider.photo;

        return AppBar(
          backgroundColor: theme.colorScheme.surface,
          title: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: hexToColor(photo?.avgColor ?? '#FFFFFF'),
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                photo?.photographer ?? 'Unknown',
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody(this.id);

  final int? id;

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (_, provider, __) {
        final theme = Theme.of(context);
        final isLoading = provider.isLoading;
        final photo = provider.photo;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (photo == null) {
          return const Center(
            child: Text('Post not found'),
          );
        }

        return RefreshIndicator(
          onRefresh: () => provider.getPostDetail(id ?? 0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: photo.src?.large2x ?? '',
                  fit: BoxFit.cover,
                  placeholder: (_, __) => ColoredBox(
                    color: theme.colorScheme.surfaceContainer,
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  errorWidget: (_, __, ___) => ColoredBox(
                    color: theme.colorScheme.surfaceContainer,
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (photo.alt?.isNotEmpty ?? false)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            photo.alt ?? '',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      Text(
                        '${photo.id ?? ''}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
