import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starter/injection/injection.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/router/app_router.dart';
import 'package:starter/utils/shared_preferences.dart';
import 'package:starter/widgets/photo_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _photos = <Photo>[];
  bool _isLoading = false;
  var _page = 1;
  var _totalResults = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _logout();
            },
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Future<void> _getPosts() async {
    setState(() => _isLoading = true);
    final result = await getIt<PostRepository>().getPhotos(
      page: _page,
      perPage: 12,
    );
    setState(() {
      _isLoading = false;
      _photos.clear();
      _photos.addAll(result.photos ?? []);
      _page = _page + 1;
      _totalResults = result.totalResults ?? 0;
    });
  }

  Future<void> _logout() async {
    getIt<SharedPreferences>().remove('username');
    context.pushReplacementNamed(AppRouter.login);
  }

  Widget _buildList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_photos.isEmpty) {
      return const Center(child: Text('No todos found'));
    }

    return RefreshIndicator(
      onRefresh: () => _getPosts(),
      child: ListView.builder(
        itemCount: _photos.length,
        itemBuilder: (_, index) => PhotoItem(
          photo: _photos[index],
        ),
      ),
    );
  }
}
