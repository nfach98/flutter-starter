import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/network/post_repository.dart';
import 'package:starter/utils/shared_preferences.dart';

@injectable
class ListProvider extends ChangeNotifier {
  final PostRepository postRepository;
  final SharedPreferences sharedPreferences;

  ListProvider({
    required this.postRepository,
    required this.sharedPreferences,
  });

  final List<Photo> _posts = [];
  bool _isLoading = false;
  int _page = 1;
  int _totalResults = 0;

  List<Photo> get posts => List.unmodifiable(_posts);
  bool get isLoading => _isLoading;

  Future<void> getPhotos() async {
    _isLoading = true;
    notifyListeners();

    final result = await postRepository.getPhotos(
      page: _page,
      perPage: 12,
    );
    _posts.clear();
    _posts.addAll(result.photos ?? []);
    _page = _page + 1;
    _totalResults = result.totalResults ?? 0;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await sharedPreferences.remove('username');
  }
}
