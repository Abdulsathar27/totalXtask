import 'package:flutter/material.dart';
import 'package:totalxtask/core/constant/app_colors.dart';
import 'package:totalxtask/core/constant/app_spacing.dart';



class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor:
        AppColors.scaffoldBackground,

    colorScheme: ColorScheme.fromSeed(
  seedColor: AppColors.primaryBlue,
),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      centerTitle: false,
      elevation: 0,
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: AppSpacing.largeSpacing,
        vertical: AppSpacing.largeSpacing,
      ),

      hintStyle: const TextStyle(
        color: AppColors.hintGrey,
        fontSize: 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSpacing.inputRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.borderGrey,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSpacing.inputRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.borderGrey,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSpacing.inputRadius,
        ),
        borderSide: const BorderSide(
          color: AppColors.primaryBlue,
          width: 1.5,
        ),
      ),
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppColors.primaryBlue,

        foregroundColor: AppColors.white,

        minimumSize: const Size(
          double.infinity,
          56,
        ),

        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.buttonRadius,
          ),
        ),

        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.white,

      elevation: 2,

      shadowColor: AppColors.cardShadow,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSpacing.cardRadius,
        ),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),

      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textDark,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textDark,
      ),
    ),
  );
}