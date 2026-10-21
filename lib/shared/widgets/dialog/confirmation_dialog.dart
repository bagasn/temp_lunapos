import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/auth/login/presentation/widgets/luna_button.dart';
import 'package:pos/l10n/app_localizations.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String message,
}) {
  final tr = AppLocalizations.of(context)!;

  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(message, style: AppTextStyles.bodyLarge),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            tr.btn_no,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textMedium,
            ),
          ),
        ),
        LunaButton(
          label: tr.btn_yes,
          width: 100,
          height: 40,
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
}
