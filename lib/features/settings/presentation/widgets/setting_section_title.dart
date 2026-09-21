import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';

/// Section title heading for settings sections.
/// Displays a large bold title matching the design mockup.
class SettingSectionTitle extends StatelessWidget {
  final String title;

  const SettingSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headlineLarge.copyWith(
        color: AppColors.textDark,
      ),
    );
  }
}
