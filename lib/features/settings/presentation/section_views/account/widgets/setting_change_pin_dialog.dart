import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/widgets/widgets/text_field/text_field.dart';

/// Dialog to change the active POS user's PIN.
///
/// Collects old PIN, new PIN and confirmation. It only validates the format
/// and that the new PIN matches its confirmation; verifying the old PIN is the
/// responsibility of the caller (via [onSubmit]).
class SettingChangePinDialog extends StatefulWidget {
  final void Function(String oldPin, String newPin) onSubmit;

  const SettingChangePinDialog({super.key, required this.onSubmit});

  @override
  State<SettingChangePinDialog> createState() => _SettingChangePinDialogState();
}

class _SettingChangePinDialogState extends State<SettingChangePinDialog> {
  static const _pinLength = 4;

  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  String? _oldPinError;
  String? _newPinError;
  String? _confirmPinError;

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations l10n) {
    final oldPin = _oldPinController.text.trim();
    final newPin = _newPinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    final lengthError = l10n.err_pinLength;

    setState(() {
      _oldPinError = oldPin.length == _pinLength ? null : lengthError;
      _newPinError = newPin.length == _pinLength ? null : lengthError;
      _confirmPinError = confirmPin.length != _pinLength
          ? lengthError
          : (confirmPin != newPin ? l10n.err_pinNotMatch : null);
    });

    if (_oldPinError != null ||
        _newPinError != null ||
        _confirmPinError != null) {
      return;
    }

    Navigator.of(context).pop();
    widget.onSubmit(oldPin, newPin);
  }

  Widget _pinField({
    required String label,
    required TextEditingController controller,
    required String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppTextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: _pinLength,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          errorText: errorText,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                l10n.btn_settingChangePin,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _pinField(
                      label: l10n.lbl_settingOldPin,
                      controller: _oldPinController,
                      errorText: _oldPinError,
                    ),
                    const SizedBox(height: 8),
                    _pinField(
                      label: l10n.lbl_settingNewPin,
                      controller: _newPinController,
                      errorText: _newPinError,
                    ),
                    const SizedBox(height: 8),
                    _pinField(
                      label: l10n.lbl_settingConfirmNewPin,
                      controller: _confirmPinController,
                      errorText: _confirmPinError,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(150, 52),
                              foregroundColor: AppColors.red700,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(l10n.btn_cancel),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(150, 52),
                            ),
                            onPressed: () => _submit(l10n),
                            child: Text(l10n.btn_save),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
