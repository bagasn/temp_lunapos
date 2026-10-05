import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

/// A numeric-only input with an explicit "Save" button, used for setting
/// values that should not be persisted on every keystroke
/// (e.g. rounding base, max queue number).
///
/// [onSave] is only called with a valid positive integer.
class SettingNumberInputField extends StatefulWidget {
  final int value;
  final ValueChanged<int> onSave;
  final String? label;
  final String? prefixText;
  final double width;

  const SettingNumberInputField({
    super.key,
    required this.value,
    required this.onSave,
    this.label,
    this.prefixText,
    this.width = 420,
  });

  @override
  State<SettingNumberInputField> createState() =>
      _SettingNumberInputFieldState();
}

class _SettingNumberInputFieldState extends State<SettingNumberInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(covariant SettingNumberInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep the field in sync when the persisted value changes externally.
    if (oldWidget.value != widget.value &&
        _controller.text != widget.value.toString()) {
      _controller.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() {
    final parsed = int.tryParse(_controller.text);
    if (parsed == null || parsed <= 0) {
      // Restore the last valid value on invalid input.
      _controller.text = widget.value.toString();
      return;
    }
    FocusScope.of(context).unfocus();
    widget.onSave(parsed);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.msg_settingSaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 4),
        ],
        SizedBox(
          width: widget.width,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTextStyles.headlineMedium,
            onSubmitted: (_) => _handleSave(),
            decoration: InputDecoration(
              prefixText: widget.prefixText,
              prefixStyle: AppTextStyles.headlineMedium,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderLight),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderLight),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 160,
          height: 48,
          child: ElevatedButton(
            onPressed: _handleSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(l10n.btn_save, style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
            )),
          ),
        ),
      ],
    );
  }
}
