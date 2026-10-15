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

    return Container(
      decoration: BoxDecoration(color: AppColors.backgroundWhite),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Assets.images.gifLoading.image(width: 52),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
