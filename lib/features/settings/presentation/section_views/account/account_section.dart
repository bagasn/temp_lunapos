import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Account Settings section view.
///
/// Displays:
/// - Current user name
/// - "Change Pin" button
class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingSectionTitle(title: l10n.title_settingAccount),
          const SizedBox(height: 24),

          // Name label
          Text(
            l10n.lbl_settingName,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Robin Richard (DEV)',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 24),

          // Change Pin button
          SizedBox(
            width: 280,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                l10n.btn_settingChangePin,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
