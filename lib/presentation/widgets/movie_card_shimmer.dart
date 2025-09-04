import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';

class MovieCardShimmer extends StatelessWidget {
  final double width;

  const MovieCardShimmer({super.key, this.width = 120});

  @override
  Widget build(BuildContext context) {
    final double height = width * 1.5;

    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 12),
      child: Shimmer.fromColors(
        baseColor: AppColors.cardDark,
        highlightColor: AppColors.surfaceDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster shimmer
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),

            // Title shimmer
            Container(
              width: width * 0.8,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),

            // Rating shimmer
            Row(
              children: [
                Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 30,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.cardDark,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListShimmer extends StatelessWidget {
  final int itemCount;
  final double itemWidth;

  const MovieListShimmer({super.key, this.itemCount = 5, this.itemWidth = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (itemWidth * 1.5) + 60, // poster height + text space
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) => MovieCardShimmer(width: itemWidth),
      ),
    );
  }
}



