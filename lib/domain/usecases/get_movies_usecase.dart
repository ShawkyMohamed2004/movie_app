import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTrendingMoviesUseCase {
  final MovieRepository repository;

  GetTrendingMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getTrendingMovies();
  }
}

class GetNowPlayingMoviesUseCase {
  final MovieRepository repository;

  GetNowPlayingMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getNowPlayingMovies();
  }
}

class GetTopRatedMoviesUseCase {
  final MovieRepository repository;

  GetTopRatedMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getTopRatedMovies();
  }
}

class GetUpcomingMoviesUseCase {
  final MovieRepository repository;

  GetUpcomingMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getUpcomingMovies();
  }
}
