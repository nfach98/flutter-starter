import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/models/post.dart';
import 'package:starter/network/post_repository.dart';

@injectable
class DetailProvider extends ChangeNotifier {
  final PostRepository postRepository;

  DetailProvider({required this.postRepository});

  Post? _post;
  bool _isLoading = false;

  Post? get post => _post;
  bool get isLoading => _isLoading;

  Future<void> getPostDetail(int id) async {
    _isLoading = true;
    notifyListeners();

    final result = await postRepository.getPostDetail(id);
    _post = result;

    _isLoading = false;
    notifyListeners();
  }
}
