import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';

@injectable
class ListProvider extends ChangeNotifier {
  final PostRepository postRepository;

  ListProvider({required this.postRepository});

  final List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => List.unmodifiable(_posts);
  bool get isLoading => _isLoading;

  Future<void> getPosts() async {
    _isLoading = true;
    notifyListeners();

    final result = await postRepository.getPosts();
    _posts.clear();
    _posts.addAll(result);

    _isLoading = false;
    notifyListeners();
  }
}
