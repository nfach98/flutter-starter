import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/models/photo.dart';
import 'package:starter/network/post_repository.dart';

@injectable
class DetailProvider extends ChangeNotifier {
  final PostRepository postRepository;

  DetailProvider({required this.postRepository});

  Photo? _photo;
  bool _isLoading = false;

  Photo? get photo => _photo;
  bool get isLoading => _isLoading;

  Future<void> getPostDetail(int id) async {
    _isLoading = true;
    notifyListeners();

    final result = await postRepository.getPhotoDetail(id);
    _photo = result;

    _isLoading = false;
    notifyListeners();
  }
}
