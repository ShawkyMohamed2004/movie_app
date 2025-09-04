import '../../domain/entities/movie_credits.dart';

class MovieCreditsModel extends MovieCredits {
  const MovieCreditsModel({required super.cast, required super.crew});

  factory MovieCreditsModel.fromJson(Map<String, dynamic> json) {
    return MovieCreditsModel(
      cast:
          (json['cast'] as List<dynamic>?)
              ?.map((cast) => CastModel.fromJson(cast))
              .toList() ??
          [],
      crew:
          (json['crew'] as List<dynamic>?)
              ?.map((crew) => CrewModel.fromJson(crew))
              .toList() ??
          [],
    );
  }
}

class CastModel extends Cast {
  const CastModel({
    required super.adult,
    super.gender,
    required super.id,
    required super.knownForDepartment,
    required super.name,
    required super.originalName,
    required super.popularity,
    super.profilePath,
    required super.castId,
    required super.character,
    required super.creditId,
    required super.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      adult: json['adult'] ?? false,
      gender: json['gender'],
      id: json['id'] ?? 0,
      knownForDepartment: json['known_for_department'] ?? '',
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      profilePath: json['profile_path'],
      castId: json['cast_id'] ?? 0,
      character: json['character'] ?? '',
      creditId: json['credit_id'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'gender': gender,
      'id': id,
      'known_for_department': knownForDepartment,
      'name': name,
      'original_name': originalName,
      'popularity': popularity,
      'profile_path': profilePath,
      'cast_id': castId,
      'character': character,
      'credit_id': creditId,
      'order': order,
    };
  }
}

class CrewModel extends Crew {
  const CrewModel({
    required super.adult,
    super.gender,
    required super.id,
    required super.knownForDepartment,
    required super.name,
    required super.originalName,
    required super.popularity,
    super.profilePath,
    required super.creditId,
    required super.department,
    required super.job,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      adult: json['adult'] ?? false,
      gender: json['gender'],
      id: json['id'] ?? 0,
      knownForDepartment: json['known_for_department'] ?? '',
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      profilePath: json['profile_path'],
      creditId: json['credit_id'] ?? '',
      department: json['department'] ?? '',
      job: json['job'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'gender': gender,
      'id': id,
      'known_for_department': knownForDepartment,
      'name': name,
      'original_name': originalName,
      'popularity': popularity,
      'profile_path': profilePath,
      'credit_id': creditId,
      'department': department,
      'job': job,
    };
  }
}
