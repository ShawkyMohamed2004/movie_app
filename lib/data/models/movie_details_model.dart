import '../../domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
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
    super.runtime,
    required super.genres,
    super.homepage,
    super.imdbId,
    required super.status,
    super.tagline,
    super.budget,
    super.revenue,
    required super.productionCompanies,
    required super.productionCountries,
    required super.spokenLanguages,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genreIds:
          (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['id'] as int)
              .toList() ??
          [],
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      adult: json['adult'] ?? false,
      video: json['video'] ?? false,
      runtime: json['runtime'],
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((genre) => GenreModel.fromJson(genre))
              .toList() ??
          [],
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      status: json['status'] ?? '',
      tagline: json['tagline'],
      budget: json['budget'],
      revenue: json['revenue'],
      productionCompanies:
          (json['production_companies'] as List<dynamic>?)
              ?.map((company) => ProductionCompanyModel.fromJson(company))
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List<dynamic>?)
              ?.map((country) => ProductionCountryModel.fromJson(country))
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>?)
              ?.map((language) => SpokenLanguageModel.fromJson(language))
              .toList() ??
          [],
    );
  }
}

class GenreModel extends Genre {
  const GenreModel({required super.id, required super.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class ProductionCompanyModel extends ProductionCompany {
  const ProductionCompanyModel({
    required super.id,
    required super.name,
    super.logoPath,
    required super.originCountry,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      logoPath: json['logo_path'],
      originCountry: json['origin_country'] ?? '',
    );
  }
}

class ProductionCountryModel extends ProductionCountry {
  const ProductionCountryModel({required super.iso31661, required super.name});

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountryModel(
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SpokenLanguageModel extends SpokenLanguage {
  const SpokenLanguageModel({
    required super.englishName,
    required super.iso6391,
    required super.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName: json['english_name'] ?? '',
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
