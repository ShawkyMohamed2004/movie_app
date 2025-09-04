import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/api_constants.dart';
import '../controllers/movie_details_controller.dart';
import '../widgets/actor_details_dialog.dart';
import '../../domain/entities/movie_credits.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsController controller;
  late int movieId;

  @override
  void initState() {
    super.initState();
    movieId = Get.arguments as int? ?? 0;

    controller = MovieDetailsController(
      getMovieDetailsUseCase: Get.find(),
      getMovieCreditsUseCase: Get.find(),
      getMovieVideosUseCase: Get.find(),
    );

    controller.loadMovieDetails(movieId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildTrailerWidget() {
    final videoId = controller.trailer?.key;
    if (videoId == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 220,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surfaceDark,
      ),
      child: Column(
        children: [
          // Trailer Title
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(
                  Icons.play_circle_filled,
                  color: AppColors.primaryAccent,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    controller.trailer?.name ?? 'Movie Trailer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Inline Video Player
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setBackgroundColor(Colors.black)
                  ..loadRequest(
                    Uri.parse(
                      'https://www.youtube.com/embed/$videoId?autoplay=0&rel=0&showinfo=0&controls=1&modestbranding=1&playsinline=1',
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Obx(() {
        if (controller.isLoading && controller.movieDetails == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryAccent),
          );
        }

        if (controller.error.isNotEmpty && controller.movieDetails == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.errorColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load movie details',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => controller.loadMovieDetails(movieId),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.movieDetails == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryAccent),
          );
        }

        final movie = controller.movieDetails!;

        return CustomScrollView(
          slivers: [
            // 1. صورة الفيلم الكبيرة في الأعلى مع وضوح أقل
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              backgroundColor: AppColors.darkBackground,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                'Movie Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (movie.backdropPath != null &&
                        movie.backdropPath!.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: ApiConstants.getOriginalImageUrl(
                          movie.backdropPath!,
                        ),
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
                            Icons.movie,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    // طبقة غامقة أكثر لتقليل الوضوح
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.5),
                            Colors.black.withValues(alpha: 0.9),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // محتوى الصفحة بالترتيب الصحيح
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.darkBackground,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. البوستر + معلومات الفيلم
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // بوستر الفيلم
                        Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:
                                movie.posterPath != null &&
                                    movie.posterPath!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: ApiConstants.getFullImageUrl(
                                      movie.posterPath!,
                                    ),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: AppColors.surfaceDark,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryAccent,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: AppColors.surfaceDark,
                                          child: const Icon(
                                            Icons.movie,
                                            size: 32,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                  )
                                : Container(
                                    color: AppColors.surfaceDark,
                                    child: const Icon(
                                      Icons.movie,
                                      size: 32,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // معلومات الفيلم
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // اسم الفيلم
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              // التقييم
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '(${movie.voteCount} votes)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // تاريخ الإصدار (السنة فقط)
                              Text(
                                'Released: ${movie.releaseDate.split('-')[0]}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // مدة الفيلم
                              Text(
                                'Runtime: ${movie.runtime} min',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // 3. نبذة عن الفيلم (Overview)
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      movie.overview.isEmpty
                          ? 'No overview available'
                          : movie.overview,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 4. الأنواع (Genres)
                    if (movie.genres.isNotEmpty) ...[
                      const Text(
                        'Genres',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: movie.genres
                            .map(
                              (genre) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAccent.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primaryAccent,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  genre.name,
                                  style: const TextStyle(
                                    color: AppColors.primaryAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 32),
                    ],

                    // 5. التريلر (يفتح في نفس الصفحة)
                    if (controller.trailer != null) ...[
                      const Text(
                        'Trailer',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTrailerWidget(),
                      const SizedBox(height: 32),
                    ],

                    // 6. طاقم التمثيل (Cast)
                    if (controller.mainCast.isNotEmpty) ...[
                      const Text(
                        'Cast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.mainCast.length,
                          itemBuilder: (context, index) {
                            final cast = controller.mainCast[index];
                            return GestureDetector(
                              onTap: () => _showActorDetails(cast),
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.only(right: 12),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor:
                                              AppColors.surfaceDark,
                                          backgroundImage:
                                              cast.profilePath != null
                                              ? CachedNetworkImageProvider(
                                                  ApiConstants.getFullImageUrl(
                                                    cast.profilePath!,
                                                  ),
                                                )
                                              : null,
                                          child: cast.profilePath == null
                                              ? const Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color:
                                                      AppColors.textSecondary,
                                                )
                                              : null,
                                        ),
                                        // Tap indicator
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryAccent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.info,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      cast.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      cast.character,
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],

                    // 7. المخرج (Director)
                    if (controller.directors.isNotEmpty) ...[
                      Text(
                        'Director${controller.directors.length > 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...controller.directors.map(
                        (director) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.surfaceDark,
                                backgroundImage: director.profilePath != null
                                    ? CachedNetworkImageProvider(
                                        ApiConstants.getFullImageUrl(
                                          director.profilePath!,
                                        ),
                                      )
                                    : null,
                                child: director.profilePath == null
                                    ? const Icon(
                                        Icons.person,
                                        size: 20,
                                        color: AppColors.textSecondary,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  director.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],

                    // 8. شركات الإنتاج (Production Companies)
                    if (movie.productionCompanies.isNotEmpty) ...[
                      const Text(
                        'Production Companies',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...movie.productionCompanies.map(
                        (company) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '• ${company.name}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Method to show actor details dialog
  void _showActorDetails(Cast cast) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ActorDetailsDialog(actor: cast),
    );
  }
}
