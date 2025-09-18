import 'package:starter/models/source.dart';

class Photo {
  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final bool? liked;
  final String? alt;
  final Source? src;

  Photo({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.liked,
    this.alt,
    this.src,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'],
        width: json['width'],
        height: json['height'],
        url: json['url'],
        photographer: json['photographer'],
        photographerUrl: json['photographer_url'],
        photographerId: json['photographer_id'],
        avgColor: json['avg_color'],
        liked: json['liked'],
        alt: json['alt'],
        src: json['src'] != null
            ? Source.fromJson(json['src'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'width': width,
        'height': height,
        'url': url,
        'photographer': photographer,
        'photographer_url': photographerUrl,
        'photographer_id': photographerId,
        'avg_color': avgColor,
        'liked': liked,
        'alt': alt,
        'src': src?.toJson(),
      };
}
