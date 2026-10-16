import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_input_model.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_text_field.dart';

/// A printer row widget for the Printer settings section.
///
/// Displays a label above a row containing a printer name input field (read-only)
/// and a "Test Print" action button.
class SettingPrinterRow extends StatelessWidget {
  final String label;
  final String printerName;
  final VoidCallback onTestPrint;
  final VoidCallback onTap;

  const SettingPrinterRow({
    super.key,
    required this.label,
    required this.printerName,
    required this.onTestPrint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: AppDropdownTextField(
                onPressed: onTap,
                prefix: Icon(Icons.print_outlined),
                hintText: 'Pilih Printer',
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: onTestPrint,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(140, 62),
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
          ],
        ),
      ],
    );
  }
}
