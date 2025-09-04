import 'package:get/get.dart';
import '../../data/services/api_service.dart';
import '../../data/services/movie_api_service.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../../domain/usecases/get_movie_extras_usecase.dart';
import '../../domain/usecases/search_movies_usecase.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../presentation/controllers/movie_details_controller.dart';
import '../../presentation/controllers/search_controller.dart';

class DependencyInjection {
  static void init() {
    // Services
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<MovieApiService>(() => MovieApiService(Get.find()));

    // Repositories
    Get.lazyPut<MovieRepository>(() => MovieRepositoryImpl(Get.find()));

    // Use Cases
    Get.put<GetTrendingMoviesUseCase>(GetTrendingMoviesUseCase(Get.find()));
    Get.put<GetNowPlayingMoviesUseCase>(GetNowPlayingMoviesUseCase(Get.find()));
    Get.put<GetTopRatedMoviesUseCase>(GetTopRatedMoviesUseCase(Get.find()));
    Get.put<GetUpcomingMoviesUseCase>(GetUpcomingMoviesUseCase(Get.find()));
    Get.put<GetMovieDetailsUseCase>(GetMovieDetailsUseCase(Get.find()));
    Get.put<GetMovieCreditsUseCase>(GetMovieCreditsUseCase(Get.find()));
    Get.put<GetMovieVideosUseCase>(GetMovieVideosUseCase(Get.find()));
    Get.put<SearchMoviesUseCase>(SearchMoviesUseCase(Get.find()));

    // Controllers
    Get.lazyPut<HomeController>(
      () => HomeController(
        getTrendingMoviesUseCase: Get.find(),
        getNowPlayingMoviesUseCase: Get.find(),
        getTopRatedMoviesUseCase: Get.find(),
        getUpcomingMoviesUseCase: Get.find(),
      ),
    );

    Get.lazyPut<MovieDetailsController>(
      () => MovieDetailsController(
        getMovieDetailsUseCase: Get.find(),
        getMovieCreditsUseCase: Get.find(),
        getMovieVideosUseCase: Get.find(),
      ),
    );

    // Register SearchController as permanent to persist search state
    Get.put<SearchController>(
      SearchController(searchMoviesUseCase: Get.find()),
      permanent: true,
    );
  }
}
