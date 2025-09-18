import 'package:starter/models/photo.dart';

class ListState {
  final List<Photo>? photos;
  final int? page;
  final int? totalResults;

  ListState({
    this.photos,
    this.page,
    this.totalResults,
  });

  factory ListState.initial() {
    return ListState(
      photos: [],
      page: 1,
      totalResults: 0,
    );
  }

  ListState copyWith({
    List<Photo>? photos,
    int? page,
    int? totalResults,
  }) {
    return ListState(
      photos: photos ?? this.photos,
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}
