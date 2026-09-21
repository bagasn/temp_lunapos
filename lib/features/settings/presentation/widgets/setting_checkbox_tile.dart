import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';

/// A reusable checkbox row for settings pages.
///
/// Displays a checkbox with a [title] and an optional [description] beneath it.
/// Used across General, Order, and Template sections.
class SettingCheckboxTile extends StatelessWidget {
  final String title;
  final String? description;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const SettingCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                if (description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    description!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
