import '../entities/movie_credits.dart';
import '../entities/movie_video.dart';
import '../repositories/movie_repository.dart';

class GetMovieCreditsUseCase {
  final MovieRepository repository;

  GetMovieCreditsUseCase(this.repository);

  Future<MovieCredits> call(int movieId) async {
    return await repository.getMovieCredits(movieId);
  }
}

class GetMovieVideosUseCase {
  final MovieRepository repository;

  GetMovieVideosUseCase(this.repository);

  Future<List<MovieVideo>> call(int movieId) async {
    return await repository.getMovieVideos(movieId);
  }
}
