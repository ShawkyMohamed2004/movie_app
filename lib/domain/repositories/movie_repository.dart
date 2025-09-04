import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../entities/movie_credits.dart';
import '../entities/movie_video.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<MovieDetails> getMovieDetails(int movieId);
  Future<MovieCredits> getMovieCredits(int movieId);
  Future<List<MovieVideo>> getMovieVideos(int movieId);
  Future<List<Movie>> searchMovies(String query);
  Future<List<Genre>> getGenres();
}
