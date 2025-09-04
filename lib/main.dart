import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/di/dependency_injection.dart';
import 'core/constants/app_constants.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/search_screen.dart';
import 'presentation/screens/movie_list_screen.dart';
import 'presentation/screens/movie_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  DependencyInjection.init();

  runApp(const MoviXApp());
}

class MoviXApp extends StatelessWidget {
  const MoviXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/movie-details', page: () => MovieDetailsScreen()),
        GetPage(name: '/movie-list', page: () => const MovieListScreen()),
      ],
      defaultTransition: Transition.cupertino,
      transitionDuration: AppConstants.shortAnimationDuration,
    );
  }
}
