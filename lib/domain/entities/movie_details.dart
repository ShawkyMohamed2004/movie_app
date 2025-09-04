import 'movie.dart';

class MovieDetails extends Movie {
  final int? runtime;
  final List<Genre> genres;
  final String? homepage;
  final String? imdbId;
  final String status;
  final String? tagline;
  final int? budget;
  final int? revenue;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<SpokenLanguage> spokenLanguages;

  const MovieDetails({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.releaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.genreIds,
    required super.originalLanguage,
    required super.originalTitle,
    required super.popularity,
    required super.adult,
    required super.video,
    this.runtime,
    required this.genres,
    this.homepage,
    this.imdbId,
    required this.status,
    this.tagline,
    this.budget,
    this.revenue,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
  });
}

class Genre {
  final int id;
  final String name;

  const Genre({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Genre && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  const ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });
}

class ProductionCountry {
  final String iso31661;
  final String name;

  const ProductionCountry({required this.iso31661, required this.name});
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  const SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });
}
