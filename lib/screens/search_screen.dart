import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/router/app_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _photos = <Photo>[];
  var _page = 1;
  var _totalResults = 0;
  bool _isLoading = false;
  bool _isWriting = false;

  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: SearchBar(
            controller: _searchController,
            elevation: const WidgetStatePropertyAll(0),
            autoFocus: false,
            textStyle: WidgetStatePropertyAll(
              theme.textTheme.bodyMedium,
            ),
            hintStyle: WidgetStatePropertyAll(
              theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.only(left: 10),
            ),
            hintText: 'Search photos...',
            leading: Icon(
              Icons.search,
              color: theme.colorScheme.outlineVariant,
            ),
            trailing: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _resetPhotos();
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
            onChanged: (query) async {
              if (query.isNotEmpty && !_isWriting) {
                setState(() => _isWriting = true);
                await Future.delayed(const Duration(milliseconds: 800));
                setState(() => _isWriting = false);
                _resetPhotos();
                _getPhotos();
              }
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTapDown: (_) => FocusScope.of(context).unfocus(),
        child: RefreshIndicator(
          onRefresh: () async {
            _resetPhotos();
            _getPhotos();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
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
    final result = await getIt<PostRepository>().searchPhotos(
      query: _searchController.text,
      page: _page,
      perPage: 21,
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
    final theme = Theme.of(context);

    if (_isLoading && _page == 1) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_photos.isEmpty) {
      return const Center(
        child: Text('Search for photos'),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _photos.length,
      itemBuilder: (_, index) {
        final photo = _photos[index];

        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.detail,
              arguments: photo.id,
            );
          },
          child: CachedNetworkImage(
            imageUrl: photo.src?.medium ?? '',
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
        );
      },
    );
  }
}
