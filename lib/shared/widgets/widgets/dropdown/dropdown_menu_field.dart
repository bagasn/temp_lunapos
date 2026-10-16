import 'package:flutter/material.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/constants/enum/input_label_suffix.dart';
import 'package:pos/shared/data/models/dropdown_item_model.dart';
import 'package:pos/shared/widgets/widgets/text_field/input_label.dart';

class AppDropdownMenuField extends StatefulWidget {
  final List<DropdownItemModel> menuItems;

  final String? label;
  final LabelSuffix labelSuffixType;
  final TextStyle? labelTextStyle;
  final DropdownItemModel? value;
  final TextStyle? valueTextStyle;
  final Widget? prefix;
  final Widget? suffix;
  final String? textHelper;
  final bool enabled;
  final String? hintText;
  final TextStyle? hintTextStyle;

  final void Function(DropdownItemModel value)? onChange;

  const AppDropdownMenuField({
    super.key,
    required this.menuItems,
    this.label,
    this.labelSuffixType = LabelSuffix.none,
    this.labelTextStyle,
    this.value,
    this.valueTextStyle,
    this.prefix,
    this.suffix = const Icon(
      Icons.arrow_drop_down,
      size: 24,
      color: AppColors.charcoal800,
    ),
    this.textHelper,
    this.enabled = true,
    this.hintText,
    this.hintTextStyle,
    this.onChange,
  });

  @override
  State<AppDropdownMenuField> createState() => _AppDropdownMenuFieldState();
}

class _AppDropdownMenuFieldState extends State<AppDropdownMenuField> {
  final GlobalKey _buttonKey = GlobalKey();

  DropdownItemModel? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final double paddingRight = widget.suffix == null ? 14 : 12;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            if (widget.enabled) {
              _showDropdown();
            }
          },
          child: Container(
            key: _buttonKey,
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
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconTheme(
                      data: IconThemeData(
                        size: 24,
                        color: AppColors.charcoal800,
                      ),
                      child: widget.prefix!,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLabelWidget(context),
                      if (_selectedValue != null) const SizedBox(height: 2),
                      _buildValueWidget(context),
                    ],
                  ),
                ),
                if (widget.suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: widget.suffix,
                  ),
              ],
            ),
          ),
        ),
        if (widget.textHelper != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: _buildTextHelperWidget(widget.textHelper!),
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
    if (_selectedValue == null) {
      if (widget.hintText != null) {
        return Text(
          widget.hintText!,
          style:
              widget.hintTextStyle ??
              TextTheme.of(
                context,
              ).bodyLarge?.copyWith(color: AppColors.charcoal700),
        );
      }
      return const SizedBox();
    }

    final widgets = <Text>[];
    widgets.add(
      Text(
        _selectedValue!.display,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style:
            widget.valueTextStyle ??
            TextTheme.of(
              context,
            ).bodyLarge?.copyWith(color: AppColors.textDark),
      ),
    );
    // if (_selectedValue?.subValues != null) {
    //   for (final sub in _selectedValue!.subValues!) {
    //     widgets.add(
    //       Text(
    //         sub,
    //         maxLines: 1,
    //         overflow: TextOverflow.ellipsis,
    //         softWrap: false,
    //         style:
    //             widget.valueTextStyle ??
    //             TextStyle(color: AppColors.charcoal800, fontSize: 12),
    //       ),
    //     );
    //   }
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [for (final widget in widgets) widget],
    );
  }

  Widget _buildLabelWidget(BuildContext context) {
    if (widget.label == null) {
      return const SizedBox();
    }

    final isLabel = _selectedValue != null;
    final style =
        widget.labelTextStyle ??
        TextStyle(fontSize: 16, color: AppColors.charcoal800);
    final labelStyle = style.copyWith(fontSize: 11);

    return InputLabelWidget(
      label: widget.label!,
      suffixType: widget.labelSuffixType,
      style: isLabel ? labelStyle : style,
    );
  }

  void _showDropdown() async {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    await showMenu<DropdownItemModel>(
      context: context,
      color: AppColors.charcoal50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3, // Bayangan standar dropdown
      constraints: BoxConstraints(
        minWidth: size.width,
        maxWidth: size.width,
        maxHeight:
            250, // Memberikan batas tinggi agar menu bisa di-scroll jika itemnya banyak
      ),
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + size.width,
        0,
      ),
      // 4. Membangun list item secara dinamis
      items: widget.menuItems.map((DropdownItemModel item) {
        final bool isSelected = _selectedValue == item;

        return PopupMenuItem<DropdownItemModel>(
          value: item,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              item.display,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextTheme.of(context).bodyLarge?.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textDark,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    ).then((DropdownItemModel? newValue) {
      if (newValue != null) {
        setState(() {
          _selectedValue = newValue;
        });
        if (widget.onChange != null) {
          widget.onChange!(newValue);
        }
      }
    });
  }
}
