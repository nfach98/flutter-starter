import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/models/quality.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/widgets/photo_item.dart';

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
        child: PhotoItem(
          photo: _photo,
          quality: Quality.large2x,
        ),
      ),
    );
  }
}
