import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

/// UI-only dialog for setting up a printer.
///
/// Uses dummy options and local state; no persistence yet.
class SettingPrinterSetupDialog extends StatefulWidget {
  const SettingPrinterSetupDialog({super.key});

  @override
  State<SettingPrinterSetupDialog> createState() =>
      _SettingPrinterSetupDialogState();
}

class _SettingPrinterSetupDialogState extends State<SettingPrinterSetupDialog> {
  static const _printerTypes = ['Escpos'];
  static const _printerModules = ['Bluetooth General', 'USB', 'LAN'];
  static const _paperSizes = ['58', '80'];
  static const _autoCutTypes = ['0', '1', '2'];

  String _printerType = _printerTypes.first;
  String _printerModule = _printerModules.first;
  String? _printer;
  String _paperSize = _paperSizes.first;
  String _autoCutType = _autoCutTypes.first;
  bool _disconnectAfterPrint = true;
  bool _autoPrintReceipt = false;
  int _copies = 1;

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
  );

  Widget _labeled(String label, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMedium),
      ),
      const SizedBox(height: 8),
      child,
    ],
  );

  Widget _dropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String hint = '',
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: _decoration(hint),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _stepButton(IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.textWhite),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      clipBehavior: Clip.antiAlias,
      backgroundColor: AppColors.backgroundWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                l10n.title_settingSelectPrinter,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _labeled(
                            l10n.lbl_settingPrinterType,
                            _dropdown(
                              value: _printerType,
                              items: _printerTypes,
                              onChanged: (v) =>
                                  setState(() => _printerType = v!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _labeled(
                            l10n.lbl_settingPrinterModule,
                            _dropdown(
                              value: _printerModule,
                              items: _printerModules,
                              onChanged: (v) =>
                                  setState(() => _printerModule = v!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _labeled(
                      l10n.lbl_settingPrinterItem,
                      _dropdown(
                        value: _printer,
                        items: const [],
                        hint: l10n.lbl_settingSelectItem,
                        onChanged: (v) => setState(() => _printer = v),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _labeled(
                            l10n.lbl_settingPaperSize,
                            _dropdown(
                              value: _paperSize,
                              items: _paperSizes,
                              onChanged: (v) => setState(() => _paperSize = v!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _labeled(
                            l10n.lbl_settingFeedAfterPrint,
                            TextFormField(
                              initialValue: '0',
                              keyboardType: TextInputType.number,
                              decoration: _decoration(''),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _labeled(
                            l10n.lbl_settingAutoCutType,
                            _dropdown(
                              value: _autoCutType,
                              items: _autoCutTypes,
                              onChanged: (v) =>
                                  setState(() => _autoCutType = v!),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _disconnectAfterPrint,
                          activeColor: AppColors.primary,
                          onChanged: (v) => setState(
                            () => _disconnectAfterPrint = v ?? false,
                          ),
                        ),
                        Text(
                          l10n.lbl_settingDisconnectAfterPrint,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.info_outline, size: 24),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          l10n.lbl_settingNumberOfCopies,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(width: 16),
                        _stepButton(Icons.remove, () {
                          if (_copies > 1) setState(() => _copies--);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '$_copies',
                            style: AppTextStyles.titleLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        _stepButton(Icons.add, () => setState(() => _copies++)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: _autoPrintReceipt,
                          activeColor: AppColors.primary,
                          onChanged: (v) =>
                              setState(() => _autoPrintReceipt = v ?? false),
                        ),
                        Expanded(
                          child: Text(
                            l10n.lbl_settingAutoPrintReceipt,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(l10n.btn_cancel),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              // UI only: Save is disabled until a printer is picked.
                              onPressed: _printer == null ? null : () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.textWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(l10n.btn_save),
                            ),
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
