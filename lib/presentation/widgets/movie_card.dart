import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/string_helper.dart';
import '../../domain/entities/movie.dart';
import 'movie_poster_widget.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final double width;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width = 140, // زيادة العرض الافتراضي من 120 لـ 140
  });

  @override
  Widget build(BuildContext context) {
    final double height = width * 1.35; // تقليل النسبة من 1.4 لـ 1.35

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // إضافة هذا لتجنب overflow
          children: [
            // Movie Poster
            Flexible(
              // إضافة Flexible
              child: MoviePosterWidget(
                posterPath: movie.posterPath,
                width: width,
                height: height,
              ),
            ),
            const SizedBox(height: 6), // تقليل المسافة من 8 لـ 6
            // Movie Title
            SizedBox(
              width: width,
              child: Text(
                movie.title,
                style: AppTypography.movieTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2), // تقليل المسافة من 4 لـ 2
            // Rating and Year
            SizedBox(
              width: width, // تحديد العرض
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // التقييم
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: AppColors.primaryYellow,
                          size: 14,
                          shadows: [
                            Shadow(
                              color: AppColors.primaryYellow.withValues(
                                alpha: 0.5,
                              ),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            StringHelper.formatRating(movie.voteAverage),
                            style: AppTypography.movieRating,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // السنة
                  if (movie.releaseDate.isNotEmpty)
                    Text(
                      movie.releaseDate.substring(0, 4),
                      style: AppTypography.metadata,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
