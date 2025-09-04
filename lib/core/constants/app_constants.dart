class AppConstants {
  static const String appName = 'MoviX';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;

  // Grid and List
  static const int moviesPerPage = 20;
  static const double movieCardAspectRatio = 0.7;
  static const int searchDebounceMilliseconds = 500;

  // Error Messages
  static const String internetErrorMessage = 'Check your internet connection';
  static const String generalErrorMessage = 'Something went wrong';
  static const String noResultsMessage = 'No movies found';

  // Movie Rating
  static const double maxRating = 10.0;
}
