import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/shared/widgets/widgets/luna_button.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String message,
  String confirmLabel = 'Ya',
  String cancelLabel = 'Batal',
}) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(message, style: AppTextStyles.bodyLarge),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            cancelLabel,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColorConstants.textMedium,
            ),
          ),
        ),
        LunaButton(
          label: confirmLabel,
          width: 100,
          height: 40,
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
}
