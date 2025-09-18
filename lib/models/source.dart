class Source {
  final String? original;
  final String? large2x;
  final String? large;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? landscape;
  final String? tiny;

  Source({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        original: json['original'],
        large2x: json['large2x'],
        large: json['large'],
        medium: json['medium'],
        small: json['small'],
        portrait: json['portrait'],
        landscape: json['landscape'],
        tiny: json['tiny'],
      );

  Map<String, dynamic> toJson() => {
        'original': original,
        'large2x': large2x,
        'large': large,
        'medium': medium,
        'small': small,
        'portrait': portrait,
        'landscape': landscape,
        'tiny': tiny,
      };
}
