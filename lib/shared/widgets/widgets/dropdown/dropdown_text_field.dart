import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/constants/enum/input_label_suffix.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_input_model.dart';
import 'package:pos/shared/widgets/widgets/text_field/input_label.dart';

class AppDropdownTextField extends StatelessWidget {
  final String label;
  final LabelSuffix labelSuffixType;
  final TextStyle? labelTextStyle;
  final DropdownInputModel? value;
  final TextStyle? valueTextStyle;
  final Widget? prefix;
  final Widget? suffix;
  final String? textHelper;
  final bool enabled;

  final void Function()? onPressed;

  const AppDropdownTextField({
    super.key,
    required this.label,
    this.labelSuffixType = LabelSuffix.none,
    this.labelTextStyle,
    this.value,
    this.valueTextStyle,
    this.prefix,
    this.suffix = const Icon(Icons.chevron_right, size: 24),
    this.textHelper,
    this.enabled = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingRight = suffix == null ? 14 : 12;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: enabled ? onPressed : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ).copyWith(right: paddingRight),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColors.charcoal700),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(minHeight: 56),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLabelWidget(context),
                      if (value != null) const SizedBox(height: 2),
                      _buildValueWidget(),
                    ],
                  ),
                ),
                if (suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: suffix,
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

  Widget _buildValueWidget() {
    if (value == null) return const SizedBox();

    final widgets = <Text>[];
    widgets.add(
      Text(
        value!.mainValue,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: valueTextStyle,
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
    final isLabel = value != null;
    final style =
        labelTextStyle ?? TextStyle(fontSize: 16, color: AppColors.charcoal800);
    final labelStyle = style.copyWith(fontSize: 11);

    return InputLabelWidget(
      label: label,
      suffixType: labelSuffixType,
      style: isLabel ? labelStyle : style,
    );
  }
}
