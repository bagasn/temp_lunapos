import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/constants/enum/input_label_suffix.dart';

class InputLabelWidget extends StatelessWidget {
  final String label;
  final LabelSuffix suffixType;
  final TextStyle? style;
  final bool enabled;

  final Color foregroundColor = AppColors.charcoal800;
  final Color disabledColor = AppColors.charcoal500;

  const InputLabelWidget({
    super.key,
    required this.label,
    this.suffixType = LabelSuffix.none,
    this.style,
    this.enabled = true,
  });

  InputLabelWidget copyWith({
    String? label,
    LabelSuffix? suffixType,
    TextStyle? style,
    bool? enabled,
  }) {
    return InputLabelWidget(
      label: label ?? this.label,
      suffixType: suffixType ?? this.suffixType,
      style: style ?? this.style,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: _getTextStyle(context)),
        _buildSuffixWidget(context),
      ],
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    TextStyle themeStyle =
        TextTheme.of(context).bodyLarge?.copyWith(
          color: enabled ? foregroundColor : disabledColor,
        ) ??
        TextStyle(
          fontSize: 16,
          color: enabled ? foregroundColor : disabledColor,
        );

    return style ?? themeStyle;
  }

  Widget _buildSuffixWidget(BuildContext context) {
    String suffixValue;
    Color textColor;

    switch (suffixType) {
      case LabelSuffix.mandatory:
        suffixValue = ' *';
        textColor = AppColors.red700;
        break;
      case LabelSuffix.optional:
        suffixValue = ' (Optional)';
        textColor = AppColors.charcoal500;
        break;
      default:
        return const SizedBox();
    }
    return Text(
      suffixValue,
      maxLines: 1,
      softWrap: false,
      style: _getTextStyle(context).copyWith(color: textColor),
    );
  }
}
