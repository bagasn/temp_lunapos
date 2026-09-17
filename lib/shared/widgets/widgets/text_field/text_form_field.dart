import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/shared/widgets/widgets/text_field/input_label.dart';

class AppTextFormField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Color backgroundColor;
  final Color backgroundActiveColor;
  final InputLabelWidget label;

  final String? errorText;
  final String? helperText;
  final bool showCounter;

  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool canRequestFocus;
  final bool readOnly;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final bool? enabled;
  final bool? ignorePointers;
  final double cursorWidth;
  final Color? cursorColor;

  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  // * Input Decoration
  final String? hintText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;

  // * Form Property
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  // * Autofill Hints
  final Iterable<String>? autofillHints;

  const AppTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.backgroundColor = AppColors.charcoal700,
    this.backgroundActiveColor = AppColors.primary,
    this.errorText,
    this.helperText,

    //* Text Component
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.readOnly = false,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.showCounter = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.keyboardAppearance,
    this.onTap,
    this.canRequestFocus = true,

    // * Decoration
    this.hintText,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,

    // * Form Property
    this.validator,
    this.onSaved,

    // * Autofill Hints
    this.autofillHints,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _isActive = false;

  String? _errorMsg;

  final Color errorColor = AppColors.red700;
  final Color disabledColor = AppColors.charcoal500;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _errorMsg = widget.errorText;

    _focusNode.addListener(() {
      setState(() {
        _isActive = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bgColorValue = (_isActive)
        ? widget.backgroundActiveColor
        : (widget.errorText != null ? errorColor : widget.backgroundColor);

    if (_errorMsg != null) {
      bgColorValue = errorColor;
    }
    if (widget.enabled == false) {
      bgColorValue = disabledColor;
    }
    double borderWidth = _isActive ? 1.5 : 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: bgColorValue,
              width: borderWidth,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            style: widget.style,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: widget.obscureText,
            autocorrect: widget.autocorrect,
            enableSuggestions: widget.enableSuggestions,
            maxLength: widget.maxLength,
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) {
                  return null;
                },
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expands,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            ignorePointers: widget.ignorePointers,
            cursorColor: widget.cursorColor,
            cursorWidth: widget.cursorWidth,
            keyboardAppearance: widget.keyboardAppearance,
            onTap: widget.onTap,
            canRequestFocus: widget.canRequestFocus,
            validator: (value) {
              if (widget.validator != null) {
                final result = widget.validator!(value);

                setState(() {
                  _errorMsg = result;
                });
                return result;
              }

              return null;
            },
            errorBuilder: (context, errorText) => SizedBox(),
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              label: widget.label.copyWith(enabled: widget.enabled),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextTheme.of(
                context,
              ).bodyLarge?.copyWith(color: AppColors.charcoal500),
              prefix: widget.prefix,
              prefixIcon: widget.prefixIcon,
              suffix: widget.suffix,
              suffixIcon: widget.suffixIcon,
            ),
            autofillHints: widget.autofillHints,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _buildHelper(
                  helper: widget.helperText,
                  error: _errorMsg,
                ),
              ),
              _buildCounter(
                textController: _controller,
                maxLength: widget.maxLength,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCounter({
    required TextEditingController textController,
    required int? maxLength,
  }) {
    if (maxLength == null || maxLength <= 0) {
      return const SizedBox();
    }
    if (!widget.showCounter) {
      return const SizedBox();
    }

    return ValueListenableBuilder(
      valueListenable: textController,
      builder: (context, value, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            '${value.text.length} / $maxLength',
            maxLines: 1,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 12, color: AppColors.charcoal800),
          ),
        );
      },
    );
  }

  Widget _buildHelper({String? helper, String? error}) {
    final color = (error != null) ? AppColors.red700 : AppColors.charcoal800;
    String? text;
    if (helper?.isNotEmpty == true) {
      text = helper;
    }
    if (error?.isNotEmpty == true) {
      text = error;
    }

    if (text == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}
