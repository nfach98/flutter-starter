import 'package:starter/models/photo.dart';

class PageResult {
  final int? page;
  final int? perPage;
  final int? totalResults;
  final String? nextPage;
  final List<Photo>? photos;

  PageResult({
    this.page,
    this.perPage,
    this.totalResults,
    this.nextPage,
    this.photos,
  });

  factory PageResult.fromJson(Map<String, dynamic> json) {
    return PageResult(
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
      totalResults: json['total_results'] as int?,
      nextPage: json['next_page'] as String?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total_results': totalResults,
      'next_page': nextPage,
      'photos': photos?.map((e) => e.toJson()).toList(),
    };
  }
}
