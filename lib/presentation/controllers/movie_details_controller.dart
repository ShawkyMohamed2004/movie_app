import 'package:get/get.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/movie_credits.dart';
import '../../domain/entities/movie_video.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../../domain/usecases/get_movie_extras_usecase.dart';

class MovieDetailsController extends GetxController {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  final GetMovieCreditsUseCase _getMovieCreditsUseCase;
  final GetMovieVideosUseCase _getMovieVideosUseCase;

  MovieDetailsController({
    required GetMovieDetailsUseCase getMovieDetailsUseCase,
    required GetMovieCreditsUseCase getMovieCreditsUseCase,
    required GetMovieVideosUseCase getMovieVideosUseCase,
  }) : _getMovieDetailsUseCase = getMovieDetailsUseCase,
       _getMovieCreditsUseCase = getMovieCreditsUseCase,
       _getMovieVideosUseCase = getMovieVideosUseCase;

  // Observable data
  final Rx<MovieDetails?> _movieDetails = Rx<MovieDetails?>(null);
  final Rx<MovieCredits?> _movieCredits = Rx<MovieCredits?>(null);
  final RxList<MovieVideo> _movieVideos = <MovieVideo>[].obs;

  // Loading states
  final RxBool _isDetailsLoading = false.obs;
  final RxBool _isCreditsLoading = false.obs;
  final RxBool _isVideosLoading = false.obs;

  // Error states
  final RxString _error = ''.obs;

  // Getters
  MovieDetails? get movieDetails => _movieDetails.value;
  MovieCredits? get movieCredits => _movieCredits.value;
  List<MovieVideo> get movieVideos => _movieVideos;

  bool get isDetailsLoading => _isDetailsLoading.value;
  bool get isCreditsLoading => _isCreditsLoading.value;
  bool get isVideosLoading => _isVideosLoading.value;

  String get error => _error.value;

  bool get isLoading => isDetailsLoading || isCreditsLoading || isVideosLoading;

  List<Cast> get mainCast {
    if (movieCredits == null) return [];
    return movieCredits!.cast.take(10).toList();
  }

  List<Crew> get directors {
    if (movieCredits == null) return [];
    return movieCredits!.crew
        .where((crew) => crew.job.toLowerCase() == 'director')
        .toList();
  }

  MovieVideo? get trailer {
    if (movieVideos.isEmpty) return null;

    // Find official trailer first
    final officialTrailer = movieVideos
        .where((video) => video.isTrailer && video.isYouTube && video.official)
        .firstOrNull;

    if (officialTrailer != null) return officialTrailer;

    // Find any trailer
    return movieVideos
        .where((video) => video.isTrailer && video.isYouTube)
        .firstOrNull;
  }

  Future<void> loadMovieDetails(int movieId) async {
    _clearData();

    await Future.wait([
      _loadMovieDetails(movieId),
      _loadMovieCredits(movieId),
      _loadMovieVideos(movieId),
    ]);
  }

  Future<void> _loadMovieDetails(int movieId) async {
    try {
      _isDetailsLoading.value = true;
      _error.value = '';

      final details = await _getMovieDetailsUseCase.call(movieId);
      _movieDetails.value = details;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isDetailsLoading.value = false;
    }
  }

  Future<void> _loadMovieCredits(int movieId) async {
    try {
      _isCreditsLoading.value = true;

      final credits = await _getMovieCreditsUseCase.call(movieId);
      _movieCredits.value = credits;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isCreditsLoading.value = false;
    }
  }

  Future<void> _loadMovieVideos(int movieId) async {
    try {
      _isVideosLoading.value = true;

      final videos = await _getMovieVideosUseCase.call(movieId);
      _movieVideos.assignAll(videos);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isVideosLoading.value = false;
    }
  }

  void _clearData() {
    _movieDetails.value = null;
    _movieCredits.value = null;
    _movieVideos.clear();
    _error.value = '';
  }

  void clearError() {
    _error.value = '';
  }
}
