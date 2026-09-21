import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';

/// A printer row widget for the Printer settings section.
///
/// Displays a label above a row containing a printer name input field (read-only)
/// and a "Test Print" action button.
class SettingPrinterRow extends StatelessWidget {
  final String label;
  final String printerName;
  final VoidCallback onTestPrint;

  const SettingPrinterRow({
    super.key,
    required this.label,
    required this.printerName,
    required this.onTestPrint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMedium,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.print_outlined,
                      size: 18,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      printerName.isEmpty ? '-' : printerName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              height: 52,
              child: ElevatedButton(
                onPressed: onTestPrint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Test Print',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
