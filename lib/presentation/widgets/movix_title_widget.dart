import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class MoviXTitleWidget extends StatelessWidget {
  final double fontSize;
  final bool withShadow;

  const MoviXTitleWidget({
    super.key,
    this.fontSize = 20,
    this.withShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background glow effect
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                AppColors.primaryPurple,
                AppColors.primaryBlue,
                AppColors.primaryTeal,
                AppColors.primaryOrange,
                AppColors.primaryYellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.25, 0.5, 0.75, 1.0],
            ).createShader(bounds),
            child: Text(
              'MoviX',
              style: GoogleFonts.orbitron(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 3.0,
                height: 1.0,
              ),
            ),
          ),
        ),
        // Additional neon outline effect
        if (withShadow)
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                'MoviX',
                style: GoogleFonts.orbitron(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3.0,
                  height: 1.0,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = AppColors.primaryTeal.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
