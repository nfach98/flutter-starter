import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_hex/class/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/models/quality.dart';
import 'package:starter/widgets/photo_placeholder.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({
    super.key,
    this.photo,
    this.quality = Quality.large,
  });

  final Photo? photo;
  final Quality quality;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = switch (quality) {
      Quality.large2x => photo?.src?.large2x,
      Quality.large => photo?.src?.large,
      Quality.medium => photo?.src?.medium,
      Quality.small => photo?.src?.small,
      Quality.original => photo?.src?.original,
      Quality.tiny => photo?.src?.tiny,
      Quality.portrait => photo?.src?.portrait,
      Quality.landscape => photo?.src?.landscape,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (_, __) => const AspectRatio(
              aspectRatio: 1,
              child: PhotoPlaceholder(),
            ),
            errorWidget: (_, __, ___) => const AspectRatio(
              aspectRatio: 1,
              child: PhotoPlaceholder(),
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
              Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: hexToColor(photo?.avgColor ?? '#FFFFFF'),
                    child: Icon(
                      Icons.person,
                      size: 10,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      photo?.photographer ?? 'Unknown',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
