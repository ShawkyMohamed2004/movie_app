class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'e5d789d679df2a98c01624e7c53a8d92';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String imageOriginalUrl = 'https://image.tmdb.org/t/p/original';

  // Movie Endpoints
  static const String trendingMovies = '/trending/movie/day';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';
  static const String movieDetails = '/movie';
  static const String searchMovies = '/search/movie';
  static const String movieGenres = '/genre/movie/list';
  static const String movieCredits = '/credits';
  static const String movieVideos = '/videos';

  // Helper method to get full image URL
  static String getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';
    return '$imageBaseUrl$imagePath';
  }

  // Helper method to get original image URL
  static String getOriginalImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';
    return '$imageOriginalUrl$imagePath';
  }
}
