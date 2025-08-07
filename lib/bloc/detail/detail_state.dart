import 'package:starter/models/post.dart';

class DetailState {
  final bool isLoading;
  final Post? post;

  DetailState({
    required this.isLoading,
    this.post,
  });

  factory DetailState.initial() => DetailState(
        isLoading: false,
      );

  DetailState copyWith({
    bool? isLoading,
    Post? post,
  }) {
    return DetailState(
      isLoading: isLoading ?? this.isLoading,
      post: post ?? this.post,
    );
  }
}
