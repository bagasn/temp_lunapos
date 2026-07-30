import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorConstants.primaryPurple,
          primary: AppColorConstants.primaryPurple,
          secondary: AppColorConstants.primaryPurpleLight,
          surface: AppColorConstants.backgroundLight,
          error: AppColorConstants.statusError,
        ),
        scaffoldBackgroundColor: AppColorConstants.backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColorConstants.primaryPurple,
          foregroundColor: AppColorConstants.textWhite,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.displayLarge,
          displayMedium: AppTextStyles.displayMedium,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.labelLarge,
          labelSmall: AppTextStyles.labelSmall,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColorConstants.surfaceInput,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColorConstants.borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColorConstants.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColorConstants.primaryPurple,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColorConstants.statusError),
          ),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColorConstants.textLight,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorConstants.primaryPurple,
            foregroundColor: AppColorConstants.textWhite,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppTextStyles.titleMedium.copyWith(
              color: AppColorConstants.textWhite,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColorConstants.primaryPurple,
            side: const BorderSide(color: AppColorConstants.primaryPurple),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppTextStyles.titleMedium,
          ),
        ),
      );
}
