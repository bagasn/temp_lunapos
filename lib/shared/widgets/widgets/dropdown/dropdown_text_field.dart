import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/constants/enum/input_label_suffix.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_input_model.dart';
import 'package:pos/shared/widgets/widgets/text_field/input_label.dart';

class AppDropdownTextField extends StatelessWidget {
  final String? label;
  final LabelSuffix labelSuffixType;
  final TextStyle? labelTextStyle;
  final DropdownInputModel? value;
  final TextStyle? valueTextStyle;
  final Widget? prefix;
  final Widget? suffix;
  final String? textHelper;
  final bool enabled;

  final void Function()? onPressed;

  final String? hintText;
  final TextStyle? hintTextStyle;

  const AppDropdownTextField({
    super.key,
    this.label,
    this.labelSuffixType = LabelSuffix.none,
    this.labelTextStyle,
    this.value,
    this.valueTextStyle,
    this.prefix,
    this.suffix = const Icon(Icons.arrow_drop_down),
    this.textHelper,
    this.enabled = true,
    this.onPressed,
    this.hintText,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingRight = suffix == null ? 14 : 12;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: enabled ? onPressed : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ).copyWith(right: paddingRight),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: enabled ? AppColors.charcoal700 : AppColors.charcoal500,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(minHeight: 56),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconTheme(
                      data: IconThemeData(
                        size: 24,
                        color: AppColors.charcoal800,
                      ),
                      child: prefix!,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLabelWidget(context),
                      if (value != null) const SizedBox(height: 2),
                      _buildValueWidget(context),
                    ],
                  ),
                ),
                if (suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconTheme(
                      data: IconThemeData(
                        size: 24,
                        color: enabled
                            ? AppColors.charcoal800
                            : AppColors.charcoal500,
                      ),
                      child: suffix!,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (textHelper != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: _buildTextHelperWidget(textHelper!),
          ),
      ],
    );
  }

  Widget _buildTextHelperWidget(String textHelper) {
    return Text(
      textHelper,
      style: TextStyle(color: AppColors.charcoal500, fontSize: 12),
    );
  }

  Widget _buildValueWidget(BuildContext context) {
    if (value == null) {
      if (hintText != null) {
        return Text(
          hintText!,
          style:
              hintTextStyle ??
              TextTheme.of(context).bodyLarge?.copyWith(
                color: enabled ? AppColors.charcoal700 : AppColors.charcoal500,
              ),
        );
      }
      return const SizedBox();
    }

    final widgets = <Text>[];
    widgets.add(
      Text(
        value!.mainValue,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style:
            valueTextStyle ??
            TextTheme.of(
              context,
            ).bodyLarge?.copyWith(color: AppColors.textDark),
      ),
    );
    if (value?.subValues != null) {
      for (final sub in value!.subValues!) {
        widgets.add(
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style:
                valueTextStyle ??
                TextStyle(color: AppColors.charcoal800, fontSize: 12),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [for (final widget in widgets) widget],
    );
  }

  Widget _buildLabelWidget(BuildContext context) {
    if (label == null) {
      return const SizedBox();
    }

    final isLabel = value != null;
    final style =
        labelTextStyle ?? TextStyle(fontSize: 16, color: AppColors.charcoal800);
    final labelStyle = style.copyWith(fontSize: 11);

    return InputLabelWidget(
      label: label!,
      suffixType: labelSuffixType,
      style: isLabel ? labelStyle : style,
    );
  }
}
