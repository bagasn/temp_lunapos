import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/constants/enum/input_label_suffix.dart';

class AppDropdownButton extends StatelessWidget {
  final String label;
  final LabelSuffix? labelType;
  final Widget? preffix;
  final Widget? suffix;
  final TextStyle? labelTextStyle;
  final Alignment? align;
  final void Function()? onPressed;

  const AppDropdownButton({
    super.key,
    required this.label,
    this.labelType,
    this.preffix,
    this.suffix,
    this.labelTextStyle,
    this.align,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        constraints: const BoxConstraints(minHeight: 38),
        decoration: BoxDecoration(
          color: AppColors.charcoal100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (preffix != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: preffix!,
              ),
            Expanded(
              child: Align(
                alignment: align ?? Alignment.centerLeft,
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  style: labelTextStyle,
                ),
              ),
            ),
            if (suffix != null)
              Padding(padding: const EdgeInsets.only(left: 12), child: suffix!),
          ],
        ),
      ),
    );
  }
}
