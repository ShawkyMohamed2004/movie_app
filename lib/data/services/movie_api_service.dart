import '../../core/constants/api_constants.dart';
import '../models/movie_model.dart';
import '../models/movie_details_model.dart';
import '../models/movie_credits_model.dart';
import '../models/movie_video_model.dart';
import 'api_service.dart';

class MovieApiService {
  final ApiService _apiService;

  MovieApiService(this._apiService);

  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response = await _apiService.get(ApiConstants.trendingMovies);
      final List<dynamic> results = response['results'] ?? [];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to get trending movies: ${e.toString()}',
      );
    }
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await _apiService.get(ApiConstants.nowPlayingMovies);
      final List<dynamic> results = response['results'] ?? [];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to get now playing movies: ${e.toString()}',
      );
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await _apiService.get(ApiConstants.topRatedMovies);
      final List<dynamic> results = response['results'] ?? [];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to get top rated movies: ${e.toString()}',
      );
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      final response = await _apiService.get(ApiConstants.upcomingMovies);
      final List<dynamic> results = response['results'] ?? [];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to get upcoming movies: ${e.toString()}',
      );
    }
  }

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      final response = await _apiService.get(
        '${ApiConstants.movieDetails}/$movieId',
      );
      return MovieDetailsModel.fromJson(response);
    } catch (e) {
      throw ApiException(
        message: 'Failed to get movie details: ${e.toString()}',
      );
    }
  }

  Future<MovieCreditsModel> getMovieCredits(int movieId) async {
    try {
      final response = await _apiService.get(
        '${ApiConstants.movieDetails}/$movieId${ApiConstants.movieCredits}',
      );
      return MovieCreditsModel.fromJson(response);
    } catch (e) {
      throw ApiException(
        message: 'Failed to get movie credits: ${e.toString()}',
      );
    }
  }

  Future<List<MovieVideoModel>> getMovieVideos(int movieId) async {
    try {
      final response = await _apiService.get(
        '${ApiConstants.movieDetails}/$movieId${ApiConstants.movieVideos}',
      );
      final List<dynamic> results = response['results'] ?? [];
      return results.map((video) => MovieVideoModel.fromJson(video)).toList();
    } catch (e) {
      throw ApiException(
        message: 'Failed to get movie videos: ${e.toString()}',
      );
    }
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _apiService.get(
        ApiConstants.searchMovies,
        queryParams: {'query': query},
      );
      final List<dynamic> results = response['results'] ?? [];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } catch (e) {
      throw ApiException(message: 'Failed to search movies: ${e.toString()}');
    }
  }

  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await _apiService.get(ApiConstants.movieGenres);
      final List<dynamic> genres = response['genres'] ?? [];
      return genres.map((genre) => GenreModel.fromJson(genre)).toList();
    } catch (e) {
      throw ApiException(message: 'Failed to get genres: ${e.toString()}');
    }
  }
}
