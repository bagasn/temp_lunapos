import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/assets.gen.dart';
import 'package:pos/generated/colors.gen.dart';

class LoginLeftPanel extends StatelessWidget {
  const LoginLeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      child: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.bgDoodlePortrait.image(fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Assets.images.imgLunaposBrandWhite.svg(width: 280),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '© 2022 - PT LUNA Aplikasi Indonesia. All rights reserved.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.charcoal200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
