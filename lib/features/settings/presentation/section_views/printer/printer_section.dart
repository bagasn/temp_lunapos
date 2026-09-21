import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_printer_row.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Printer Settings section view.
///
/// Displays:
/// - Three printer rows: Main, Captain Order, Label
/// - "Add Printer Area" button
class PrinterSection extends StatelessWidget {
  const PrinterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingSectionTitle(title: l10n.title_settingPrinter),
          const SizedBox(height: 24),

          SettingPrinterRow(
            label: l10n.lbl_settingPrinterMain,
            printerName: '',
            onTestPrint: () {},
          ),
          const SizedBox(height: 20),

          SettingPrinterRow(
            label: l10n.lbl_settingPrinterCaptainOrder,
            printerName: '',
            onTestPrint: () {},
          ),
          const SizedBox(height: 20),

          SettingPrinterRow(
            label: l10n.lbl_settingPrinterLabel,
            printerName: '',
            onTestPrint: () {},
          ),
          const SizedBox(height: 24),

          // Add Printer Area button
          SizedBox(
            width: 280,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add, color: AppColors.textWhite),
              label: Text(
                l10n.btn_settingAddPrinterArea,
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
