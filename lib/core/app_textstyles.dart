import 'package:flutter/material.dart';
import 'package:skincare/core/app_colors.dart';

class AppTextStyles {
  static const headlineLarge = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 38,
    height: 48 / 38,
    letterSpacing: 0.38,
    color: AppColors.textHeadline,
  );

  static const headlineMedium = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 22,
    height: 26 / 22,
    letterSpacing: 0.44,
    color: AppColors.textHeadline,
  );

  static const titleLarge = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w700,
    fontSize: 18,
    height: 20 / 18,
    letterSpacing: 0.36,
    color: AppColors.textPrimary,
  );

  static const titleMedium = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 16,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static const bodyLarge = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w500,
    fontSize: 16,
    height: 22 / 16,
    color: AppColors.black,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.28,
    color: AppColors.textSecondary,
  );

  static const bodySmall = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 13,
    height: 18 / 13,
    color: AppColors.promoSubtitle,
  );

  static const labelLarge = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 16,
    height: 24 / 16,
    color: AppColors.white,
  );

  static const labelMedium = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.black,
  );

  static const labelSmall = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w500,
    fontSize: 12,
    height: 14 / 12,
    letterSpacing: 0.24,
    color: AppColors.textSecondary,
  );

  static const chip = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 14,
    height: 16 / 14,
    color: AppColors.textDark,
  );

  static const chipSelected = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 14,
    height: 16 / 14,
    color: AppColors.white,
  );

  static const caption = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.navActive,
  );

  static const rating = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 10,
    height: 14 / 10,
    color: AppColors.ratingMuted,
  );

  static const price = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.black,
  );

  static const productTitle = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w500,
    fontSize: 12,
    height: 1.2,
    color: AppColors.black,
  );

  static const buttonSmall = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w600,
    fontSize: 12,
    color: AppColors.white,
  );

  static const promoTag = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 10,
    height: 20 / 10,
    color: AppColors.promoTagBorder,
  );

  static const searchHint = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w400,
    fontSize: 14,
    height: 24 / 14,
    color: AppColors.searchHint,
  );

  static const logo = TextStyle(
    fontFamily: 'MonaSans',
    fontWeight: .w500,
    fontSize: 19,
    height: 20 / 19,
    letterSpacing: 0.57,
  );
}
