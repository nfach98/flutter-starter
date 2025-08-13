import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_hex/class/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:starter/models/photo.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({super.key, this.photo});

  final Photo? photo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
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
              Expanded(
                child: Text(
                  photo?.photographer ?? 'Unknown',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: photo?.src?.large2x ?? '',
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
              if (photo?.alt?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    photo?.alt ?? '',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              Text(
                '${photo?.id ?? ''}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
