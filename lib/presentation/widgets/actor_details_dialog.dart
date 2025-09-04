import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/api_constants.dart';
import '../../domain/entities/movie_credits.dart';

class ActorDetailsDialog extends StatelessWidget {
  final Cast actor;

  const ActorDetailsDialog({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with close button
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Actor Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Actor content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Actor photo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryAccent.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child:
                            actor.profilePath != null &&
                                actor.profilePath!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: ApiConstants.getFullImageUrl(
                                  actor.profilePath!,
                                ),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.surfaceDark,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryAccent,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppColors.surfaceDark,
                                  child: const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            : Container(
                                color: AppColors.surfaceDark,
                                child: const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Actor name
                    Text(
                      actor.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Character name
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryAccent,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'as ${actor.character}',
                        style: TextStyle(
                          color: AppColors.primaryAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Additional info
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (actor.knownForDepartment.isNotEmpty) ...[
                              _buildInfoCard(
                                'Known For',
                                actor.knownForDepartment,
                                Icons.star,
                              ),
                              const SizedBox(height: 12),
                            ],

                            _buildInfoCard(
                              'Department',
                              actor.knownForDepartment,
                              Icons.work,
                            ),

                            const SizedBox(height: 12),

                            _buildInfoCard(
                              'Cast Order',
                              '#${actor.order + 1}',
                              Icons.format_list_numbered,
                            ),

                            const SizedBox(height: 12),

                            if (actor.popularity > 0) ...[
                              _buildInfoCard(
                                'Popularity',
                                '${actor.popularity.toStringAsFixed(1)}⭐',
                                Icons.trending_up,
                              ),
                              const SizedBox(height: 12),
                            ],

                            if (actor.originalName != actor.name) ...[
                              _buildInfoCard(
                                'Original Name',
                                actor.originalName,
                                Icons.abc,
                              ),
                              const SizedBox(height: 12),
                            ],

                            const SizedBox(height: 20),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Navigate to actor's movies
                                      Navigator.pop(context);
                                      Get.snackbar(
                                        'Coming Soon',
                                        'Actor filmography feature will be added soon!',
                                        backgroundColor:
                                            AppColors.primaryAccent,
                                        colorText: Colors.white,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryAccent,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.movie, size: 20),
                                    label: const Text('View Movies'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.primaryAccent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
