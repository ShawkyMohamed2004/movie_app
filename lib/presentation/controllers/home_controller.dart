import 'package:get/get.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies_usecase.dart';

class HomeController extends GetxController {
  final GetTrendingMoviesUseCase _getTrendingMoviesUseCase;
  final GetNowPlayingMoviesUseCase _getNowPlayingMoviesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final GetUpcomingMoviesUseCase _getUpcomingMoviesUseCase;

  HomeController({
    required GetTrendingMoviesUseCase getTrendingMoviesUseCase,
    required GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase,
    required GetTopRatedMoviesUseCase getTopRatedMoviesUseCase,
    required GetUpcomingMoviesUseCase getUpcomingMoviesUseCase,
  }) : _getTrendingMoviesUseCase = getTrendingMoviesUseCase,
       _getNowPlayingMoviesUseCase = getNowPlayingMoviesUseCase,
       _getTopRatedMoviesUseCase = getTopRatedMoviesUseCase,
       _getUpcomingMoviesUseCase = getUpcomingMoviesUseCase;

  // Observable lists
  final RxList<Movie> _trendingMovies = <Movie>[].obs;
  final RxList<Movie> _nowPlayingMovies = <Movie>[].obs;
  final RxList<Movie> _topRatedMovies = <Movie>[].obs;
  final RxList<Movie> _upcomingMovies = <Movie>[].obs;

  // Loading states
  final RxBool _isTrendingLoading = false.obs;
  final RxBool _isNowPlayingLoading = false.obs;
  final RxBool _isTopRatedLoading = false.obs;
  final RxBool _isUpcomingLoading = false.obs;

  // Error states
  final RxString _error = ''.obs;

  // Getters
  List<Movie> get trendingMovies => _trendingMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;

  bool get isTrendingLoading => _isTrendingLoading.value;
  bool get isNowPlayingLoading => _isNowPlayingLoading.value;
  bool get isTopRatedLoading => _isTopRatedLoading.value;
  bool get isUpcomingLoading => _isUpcomingLoading.value;

  String get error => _error.value;

  bool get isLoading =>
      isTrendingLoading ||
      isNowPlayingLoading ||
      isTopRatedLoading ||
      isUpcomingLoading;

  @override
  void onInit() {
    super.onInit();
    loadAllMovies();
  }

  Future<void> loadAllMovies() async {
    await Future.wait([
      loadTrendingMovies(),
      loadNowPlayingMovies(),
      loadTopRatedMovies(),
      loadUpcomingMovies(),
    ]);
  }

  Future<void> loadTrendingMovies() async {
    try {
      _isTrendingLoading.value = true;
      _error.value = '';

      final movies = await _getTrendingMoviesUseCase.call();
      _trendingMovies.assignAll(movies);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isTrendingLoading.value = false;
    }
  }

  Future<void> loadNowPlayingMovies() async {
    try {
      _isNowPlayingLoading.value = true;
      _error.value = '';

      final movies = await _getNowPlayingMoviesUseCase.call();
      _nowPlayingMovies.assignAll(movies);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isNowPlayingLoading.value = false;
    }
  }

  Future<void> loadTopRatedMovies() async {
    try {
      _isTopRatedLoading.value = true;
      _error.value = '';

      final movies = await _getTopRatedMoviesUseCase.call();
      _topRatedMovies.assignAll(movies);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isTopRatedLoading.value = false;
    }
  }

  Future<void> loadUpcomingMovies() async {
    try {
      _isUpcomingLoading.value = true;
      _error.value = '';

      final movies = await _getUpcomingMoviesUseCase.call();
      _upcomingMovies.assignAll(movies);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isUpcomingLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await loadAllMovies();
  }

  void clearError() {
    _error.value = '';
  }
}
