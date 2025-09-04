import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // ========== العناوين الأساسية الكبيرة - Orbitron ==========
  static TextStyle get displayLarge => GoogleFonts.orbitron(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
  );

  static TextStyle get displayMedium => GoogleFonts.orbitron(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  // ========== العناوين الفرعية - Oswald ==========
  static TextStyle get headlineLarge => GoogleFonts.oswald(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 1.2,
  );

  static TextStyle get headlineMedium => GoogleFonts.oswald(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.0,
  );

  static TextStyle get headlineSmall => GoogleFonts.oswald(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.8,
  );

  // ========== عناوين الكروت والأقسام - Oswald ==========
  static TextStyle get titleLarge => GoogleFonts.oswald(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle get titleMedium => GoogleFonts.oswald(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  static TextStyle get titleSmall => GoogleFonts.oswald(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  // ========== النصوص العادية - Roboto ==========
  static TextStyle get bodyLarge => GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // ========== النصوص الصغيرة - Inter ==========
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // ========== خطوط خاصة ==========

  // للوجو الرئيسي
  static TextStyle get logo => GoogleFonts.orbitron(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
  );

  // لعناوين الأفلام في الكروت
  static TextStyle get movieTitle => GoogleFonts.oswald(
    fontSize: 13, // تقليل من 14 لـ 13
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.2, // تقليل المسافات
    height: 1.1, // تقليل ارتفاع السطر
  );

  // لتقييمات الأفلام
  static TextStyle get movieRating => GoogleFonts.roboto(
    fontSize: 11, // تقليل من 12 لـ 11
    fontWeight: FontWeight.w500,
    color: AppColors.primaryYellow,
  );

  // للتواريخ والمعلومات الإضافية
  static TextStyle get metadata => GoogleFonts.inter(
    fontSize: 10, // تقليل من 11 لـ 10
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );
}
