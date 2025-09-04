import 'package:get/get.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/movie_details_screen.dart';
import '../../presentation/screens/movie_list_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String movieDetails = '/movie-details';
  static const String movieList = '/movie-list';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomeScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: search, page: () => const SearchScreen()),
    GetPage(name: movieDetails, page: () => const MovieDetailsScreen()),
    GetPage(name: movieList, page: () => const MovieListScreen()),
  ];
}
