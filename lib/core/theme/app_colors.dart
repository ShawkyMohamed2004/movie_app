import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Cinema Neon Theme (inspired by movie/popcorn image)
  static const Color primaryPurple = Color(0xFF8B5CF6); // Vibrant purple
  static const Color primaryBlue = Color(0xFF3B82F6); // Electric blue
  static const Color primaryTeal = Color(0xFF06B6D4); // Cyan accent
  static const Color primaryOrange = Color(0xFFFF8C00); // Bright orange
  static const Color primaryYellow = Color(0xFFFFD700); // Golden yellow
  static const Color primaryAccent = Color(0xFF8B5CF6); // Main accent (purple)

  // Background Colors - Dark Cinema Theme
  static const Color darkBackground = Color(0xFF0A0B1E); // Deep purple-black
  static const Color surfaceDark = Color(0xFF1A1B3A); // Dark purple
  static const Color cardDark = Color(0xFF252652); // Card purple

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE2E8F0); // Light gray
  static const Color textTertiary = Color(0xFFCBD5E1); // Medium gray
  static const Color textHint = Color(0xFF94A3B8); // Hint gray

  // Accent Colors - Neon Theme
  static const Color goldAccent = Color(0xFFFFD700); // Golden yellow
  static const Color ratingColor = Color(0xFFFFD700); // Rating stars
  static const Color neonBlue = Color(0xFF00D9FF); // Neon blue
  static const Color neonPurple = Color(0xFFB847FF); // Neon purple
  static const Color neonOrange = Color(0xFFFF6B35); // Neon orange

  // System Colors
  static const Color successColor = Color(0xFF22C55E); // Green
  static const Color errorColor = Color(0xFFEF4444); // Red
  static const Color warningColor = Color(0xFFF59E0B); // Orange

  // Gradients - Cinema Neon Theme
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0x60000000), Color(0xFF0A0B1E)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF06B6D4), Color(0xFFFF8C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1B3A), Color(0xFF252652)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Additional Colors
  static const Color cardBackground = cardDark;
  static const Color surfaceColor = surfaceDark;
}
