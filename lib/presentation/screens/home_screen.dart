import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../widgets/movie_section.dart';
import '../widgets/hero_slider.dart';
import '../widgets/movix_title_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() => _buildBody()),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/movix_logo.png',
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          const MoviXTitleWidget(fontSize: 22),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: AppColors.cardGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => Get.toNamed('/search'),
            icon: const Icon(Icons.search_rounded),
            color: AppColors.primaryTeal,
          ),
        ),
      ],
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    if (controller.error.isNotEmpty && !controller.isLoading) {
      return _buildErrorState();
    }

    return RefreshIndicator(
      onRefresh: controller.refresh,
      color: AppColors.primaryAccent,
      backgroundColor: AppColors.cardDark,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Hero Slider with Trending Movies
            if (controller.trendingMovies.isNotEmpty) ...[
              HeroSlider(movies: controller.trendingMovies),
              const SizedBox(height: 32),
            ],

            // Now Playing Movies
            MovieSection(
              title: 'Now Playing',
              movies: controller.nowPlayingMovies,
              isLoading: controller.isNowPlayingLoading,
              onMovieTap: (movie) =>
                  Get.toNamed('/movie-details', arguments: movie.id),
              onSeeAll: () => Get.toNamed(
                '/movie-list',
                arguments: {
                  'title': 'Now Playing',
                  'movies': controller.nowPlayingMovies,
                },
              ),
            ),

            const SizedBox(height: 32),

            // Top Rated Movies
            MovieSection(
              title: 'Top Rated',
              movies: controller.topRatedMovies,
              isLoading: controller.isTopRatedLoading,
              onMovieTap: (movie) =>
                  Get.toNamed('/movie-details', arguments: movie.id),
              onSeeAll: () => Get.toNamed(
                '/movie-list',
                arguments: {
                  'title': 'Top Rated',
                  'movies': controller.topRatedMovies,
                },
              ),
            ),

            const SizedBox(height: 32),

            // Upcoming Movies
            MovieSection(
              title: 'Upcoming',
              movies: controller.upcomingMovies,
              isLoading: controller.isUpcomingLoading,
              onMovieTap: (movie) =>
                  Get.toNamed('/movie-details', arguments: movie.id),
              onSeeAll: () => Get.toNamed(
                '/movie-list',
                arguments: {
                  'title': 'Upcoming Movies',
                  'movies': controller.upcomingMovies,
                },
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: AppColors.errorColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: Get.textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              controller.error,
              style: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              controller.clearError();
              controller.refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: AppColors.textPrimary,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
