import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_colors.dart';
import 'package:pos/core/theme/app_text_styles.dart';

enum LunaButtonVariant { primary, outlined, ghost }

class LunaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final LunaButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double height;

  const LunaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = LunaButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: switch (variant) {
        LunaButtonVariant.primary => ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            child: _buildContent(),
          ),
        LunaButtonVariant.outlined => OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            child: _buildContent(),
          ),
        LunaButtonVariant.ghost => TextButton(
            onPressed: isLoading ? null : onPressed,
            child: _buildContent(),
          ),
      },
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColorConstants.textWhite,
        ),
      );
    }
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.titleMedium),
        ],
      );
    }
    return Text(label, style: AppTextStyles.titleMedium);
  }
}
