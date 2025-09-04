import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/api_constants.dart';
import '../../core/theme/app_colors.dart';

class MoviePosterWidget extends StatelessWidget {
  final String? posterPath;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const MoviePosterWidget({
    super.key,
    this.posterPath,
    this.width = 120,
    this.height = 180,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(12);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        gradient: AppColors.cardGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: posterPath != null
            ? CachedNetworkImage(
                imageUrl: ApiConstants.getFullImageUrl(posterPath!),
                width: width,
                height: height,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerPlaceholder(),
                errorWidget: (context, url, error) => _buildErrorPlaceholder(),
              )
            : _buildErrorPlaceholder(),
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: AppColors.cardDark,
      highlightColor: AppColors.primaryPurple.withValues(alpha: 0.2),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(gradient: AppColors.cardGradient),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.cardDark,
      child: const Icon(
        Icons.movie_outlined,
        color: AppColors.textSecondary,
        size: 40,
      ),
    );
  }
}
