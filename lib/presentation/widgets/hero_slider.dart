import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/api_constants.dart';
import '../../domain/entities/movie.dart';

class HeroSlider extends StatefulWidget {
  final List<Movie> movies;

  const HeroSlider({super.key, required this.movies});

  @override
  State<HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (widget.movies.isNotEmpty && mounted) {
        _currentIndex = (_currentIndex + 1) % widget.movies.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return _buildPlaceholder();
    }

    return SizedBox(
      height: 480,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              return _buildSlideItem(widget.movies[index]);
            },
          ),
          // Dots Indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.movies.length,
                (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideItem(Movie movie) {
    return GestureDetector(
      onTap: () => Get.toNamed('/movie-details', arguments: movie.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
              blurRadius: 40,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: AppColors.cardGradient,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              _buildBackgroundImage(movie),

              // Gradient Overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.heroGradient,
                ),
              ),

              // Content
              Positioned(
                bottom: 60,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.7),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Rating & Year
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.goldAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.7),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          movie.releaseDate.split('-')[0],
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.7),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Play Button
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPurple.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Get.toNamed('/movie-details', arguments: movie.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow, size: 20),
                        label: const Text(
                          'Watch Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(Movie movie) {
    // Use backdrop image first, fallback to poster if backdrop is not available
    String? imagePath = movie.backdropPath;
    if (imagePath == null || imagePath.isEmpty) {
      imagePath = movie.posterPath;
    }

    // If no image is available at all, show a gradient background
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple.withValues(alpha: 0.8),
              AppColors.primaryBlue.withValues(alpha: 0.8),
              AppColors.primaryTeal.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: const Center(
          child: Icon(Icons.movie, size: 80, color: Colors.white),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: ApiConstants.getOriginalImageUrl(imagePath),
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple.withValues(alpha: 0.3),
              AppColors.primaryBlue.withValues(alpha: 0.3),
              AppColors.primaryTeal.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryAccent),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple.withValues(alpha: 0.6),
              AppColors.primaryBlue.withValues(alpha: 0.6),
              AppColors.primaryTeal.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: const Center(
          child: Icon(Icons.movie, size: 80, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentIndex == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        gradient: _currentIndex == index ? AppColors.neonGradient : null,
        color: _currentIndex == index
            ? null
            : Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(4),
        boxShadow: _currentIndex == index
            ? [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 480,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primaryAccent),
      ),
    );
  }
}
