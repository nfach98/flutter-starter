import 'package:starter/models/post.dart';

class ListState {
  final bool isLoading;
  final bool isLogout;
  final List<Post> posts;

  ListState({
    required this.isLoading,
    this.isLogout = false,
    required this.posts,
  });

  factory ListState.initial() => ListState(
        isLoading: false,
        posts: [],
      );

  ListState copyWith({
    bool? isLoading,
    bool? isLogout,
    List<Post>? posts,
  }) {
    return ListState(
      isLoading: isLoading ?? this.isLoading,
      isLogout: isLogout ?? this.isLogout,
      posts: posts ?? this.posts,
    );
  }
}
