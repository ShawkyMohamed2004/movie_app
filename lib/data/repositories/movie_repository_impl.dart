import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/movie_credits.dart';
import '../../domain/entities/movie_video.dart';
import '../../domain/repositories/movie_repository.dart';
import '../services/movie_api_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _movieApiService;

  MovieRepositoryImpl(this._movieApiService);

  @override
  Future<List<Movie>> getTrendingMovies() async {
    return await _movieApiService.getTrendingMovies();
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    return await _movieApiService.getNowPlayingMovies();
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    return await _movieApiService.getTopRatedMovies();
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    return await _movieApiService.getUpcomingMovies();
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    return await _movieApiService.getMovieDetails(movieId);
  }

  @override
  Future<MovieCredits> getMovieCredits(int movieId) async {
    return await _movieApiService.getMovieCredits(movieId);
  }

  @override
  Future<List<MovieVideo>> getMovieVideos(int movieId) async {
    return await _movieApiService.getMovieVideos(movieId);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await _movieApiService.searchMovies(query);
  }

  @override
  Future<List<Genre>> getGenres() async {
    return await _movieApiService.getGenres();
  }
}
