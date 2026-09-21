import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Dual Display Settings section view.
///
/// Displays:
/// - "Activate Dual Display" toggle row (highlighted card)
/// - "Customer Display" section label
class DualDisplaySection extends StatefulWidget {
  const DualDisplaySection({super.key});

  @override
  State<DualDisplaySection> createState() => _DualDisplaySectionState();
}

class _DualDisplaySectionState extends State<DualDisplaySection> {
  bool _isDualDisplayActive = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activate Dual Display card
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEFF7EC),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.lbl_settingActivateDualDisplay,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Switch(
                  value: _isDualDisplayActive,
                  onChanged: (val) =>
                      setState(() => _isDualDisplayActive = val),
                  activeThumbColor: AppColors.primary,
                  activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Customer Display label
          Text(
            l10n.lbl_settingCustomerDisplay,
            style: AppTextStyles.headlineMedium,
          ),
        ],
      ),
    );
  }
}
