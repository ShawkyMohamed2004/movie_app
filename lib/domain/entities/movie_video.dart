class MovieVideo {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  const MovieVideo({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  bool get isTrailer => type.toLowerCase() == 'trailer';
  bool get isYouTube => site.toLowerCase() == 'youtube';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVideo && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
