import 'package:flutter/material.dart';
import 'package:pos/generated/assets.gen.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

class AppLoadingWidget extends StatelessWidget {
  final dynamic progress;

  const AppLoadingWidget({super.key, this.progress});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    String message = 'Mohon Tunggu...';
    if (progress != null && progress is String) {
      message = progress;
    }

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(maxWidth: 250),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.gifLoading.image(width: 82, height: 82),
            SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextTheme.of(context).bodyLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
