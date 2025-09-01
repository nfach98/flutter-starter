import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/models/quality.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/widgets/photo_item.dart';

@RoutePage()
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _photos = <Photo>[];
  var _page = 1;
  var _totalResults = 0;
  bool _isLoading = false;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPhotos();
      _scrollController.addListener(() {
        final pos = _scrollController.position;
        if (pos.pixels == pos.maxScrollExtent && !_isLoading) {
          _getPhotos();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _resetPhotos();
            _getPhotos();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                AppBar(
                  title: const Text('Curated'),
                  centerTitle: true,
                ),
                _buildList(),
                if (_photos.length < _totalResults)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getPhotos() async {
    setState(() => _isLoading = true);
    final result = await getIt<PostRepository>().getPhotos(
      page: _page,
      perPage: 12,
    );
    setState(() {
      _isLoading = false;
      _photos.addAll(result.photos ?? []);
      _page = _page + 1;
      _totalResults = result.totalResults ?? 0;
    });
  }

  _resetPhotos() {
    setState(() {
      _photos.clear();
      _page = 1;
      _totalResults = 0;
    });
  }

  Widget _buildList() {
    if (_isLoading && _page == 1) {
      return const Center(child: CircularProgressIndicator());
    } else if (_photos.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _photos.length,
      itemBuilder: (_, index) => PhotoItem(
        photo: _photos[index],
        quality: Quality.large,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}
