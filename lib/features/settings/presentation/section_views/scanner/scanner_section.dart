import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Scanner Settings section view.
///
/// Displays a segmented toggle button to select scanner mode: HID or SPP.
class ScannerSection extends StatefulWidget {
  const ScannerSection({super.key});

  @override
  State<ScannerSection> createState() => _ScannerSectionState();
}

class _ScannerSectionState extends State<ScannerSection> {
  int _selectedMode = 0; // 0 = HID, 1 = SPP

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingSectionTitle(title: l10n.title_settingScanner),
          const SizedBox(height: 24),

          // Segmented toggle: HID | SPP
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.charcoal100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMode = 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _selectedMode == 0
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.lbl_settingScannerHid,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: _selectedMode == 0
                              ? AppColors.textWhite
                              : AppColors.textMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMode = 1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _selectedMode == 1
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.lbl_settingScannerSpp,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: _selectedMode == 1
                              ? AppColors.textWhite
                              : AppColors.textMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
