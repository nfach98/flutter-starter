import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_hex/class/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/network/post_repository.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, this.id});

  final int? id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Photo? _photo;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPhotoDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: const Text('Detail'),
      ),
      body: _buildPostDetail(),
    );
  }

  Future<void> _getPhotoDetail() async {
    setState(() => _isLoading = true);
    final result = await getIt<PostRepository>().getPhotoDetail(
      widget.id ?? 0,
    );
    setState(() {
      _isLoading = false;
      _photo = result;
    });
  }

  Widget _buildPostDetail() {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_photo == null) {
      return const Center(
        child: Text('Post not found'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _getPhotoDetail(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: hexToColor(_photo?.avgColor ?? '#FFFFFF'),
                    child: Icon(
                      Icons.person,
                      size: 16,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _photo?.photographer ?? 'Unknown',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: CachedNetworkImage(
                imageUrl: _photo?.src?.large ?? '',
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
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_photo?.alt?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        _photo?.alt ?? '',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  Text(
                    '${_photo?.id ?? ''}',
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
  }
}
