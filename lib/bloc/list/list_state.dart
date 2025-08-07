import 'package:starter/models/post.dart';

class ListState {
  final bool isLoading;
  final List<Post> posts;

  ListState({
    required this.isLoading,
    required this.posts,
  });

  factory ListState.initial() => ListState(
        isLoading: false,
        posts: [],
      );

  ListState copyWith({
    bool? isLoading,
    List<Post>? posts,
  }) {
    return ListState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
    );
  }
}
