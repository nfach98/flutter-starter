import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/models/quality.dart';
import 'package:starter/riverpod/list_notifier.dart';
import 'package:starter/widgets/photo_item.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    final isLoading = ref.read(listNotifierProvider).isLoading;
    if (pos.pixels == pos.maxScrollExtent && !isLoading) {
      ref.read(listNotifierProvider.notifier).getPhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          data: (posts) {
            final photos = posts?.photos ?? [];
            final totalResults = posts?.totalResults ?? 0;

            return RefreshIndicator(
              onRefresh: () async {
                ref.read(listNotifierProvider.notifier).resetPhotos();
                await ref.read(listNotifierProvider.notifier).getPhotos();
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    AppBar(
                      title: const Text('Curated'),
                      centerTitle: true,
                    ),
                    _buildList(photos),
                    if (photos.length < totalResults)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildList(List<Photo> photos) {
    if (photos.isEmpty) {
      return const Center(
        child: Text('No photos found'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photos.length,
      itemBuilder: (_, index) => PhotoItem(
        photo: photos[index],
        quality: Quality.large,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}
