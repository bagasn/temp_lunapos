import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/widgets/setting_checkbox_tile.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Template Settings section view.
///
/// Displays two sub-groups: Bill and Receipt, each with the same
/// set of template element checkboxes.
class TemplateSection extends StatefulWidget {
  const TemplateSection({super.key});

  @override
  State<TemplateSection> createState() => _TemplateSectionState();
}

class _TemplateSectionState extends State<TemplateSection> {
  // Bill checkboxes
  bool _billLogo = true;
  bool _billOrderNumber = true;
  bool _billOrderDate = true;
  bool _billAddress = true;
  bool _billCashierAndUser = true;
  bool _billAdjusmentAmount = true;
  bool _billTax = true;
  bool _billServiceCharge = true;
  bool _billProductUnitPrice = true;
  bool _billModifierUnitPrice = true;

  // Receipt checkboxes
  bool _receiptLogo = true;
  bool _receiptOrderNumber = true;
  bool _receiptOrderDate = true;
  bool _receiptAddress = true;
  bool _receiptCashierAndUser = true;
  bool _receiptAdjusmentAmount = true;
  bool _receiptTax = true;
  bool _receiptServiceCharge = true;
  bool _receiptProductUnitPrice = true;
  bool _receiptModifierUnitPrice = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingSectionTitle(title: l10n.title_settingTemplate),
          const SizedBox(height: 24),

          // Bill sub-section
          Text(l10n.lbl_settingBill, style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          SettingCheckboxTile(
            title: l10n.lbl_settingLogo,
            value: _billLogo,
            onChanged: (v) => setState(() => _billLogo = v ?? _billLogo),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderNumber,
            value: _billOrderNumber,
            onChanged: (v) =>
                setState(() => _billOrderNumber = v ?? _billOrderNumber),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderDate,
            value: _billOrderDate,
            onChanged: (v) =>
                setState(() => _billOrderDate = v ?? _billOrderDate),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAddress,
            value: _billAddress,
            onChanged: (v) => setState(() => _billAddress = v ?? _billAddress),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingCashierAndUser,
            value: _billCashierAndUser,
            onChanged: (v) =>
                setState(() => _billCashierAndUser = v ?? _billCashierAndUser),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAdjusmentAmount,
            value: _billAdjusmentAmount,
            onChanged: (v) => setState(
                () => _billAdjusmentAmount = v ?? _billAdjusmentAmount),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingTax,
            value: _billTax,
            onChanged: (v) => setState(() => _billTax = v ?? _billTax),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingServiceCharge,
            value: _billServiceCharge,
            onChanged: (v) =>
                setState(() => _billServiceCharge = v ?? _billServiceCharge),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingProductUnitPrice,
            value: _billProductUnitPrice,
            onChanged: (v) => setState(
                () => _billProductUnitPrice = v ?? _billProductUnitPrice),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingModifierUnitPrice,
            value: _billModifierUnitPrice,
            onChanged: (v) => setState(
                () => _billModifierUnitPrice = v ?? _billModifierUnitPrice),
          ),
          const SizedBox(height: 24),

          // Receipt sub-section
          Text(l10n.lbl_settingReceipt, style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          SettingCheckboxTile(
            title: l10n.lbl_settingLogo,
            value: _receiptLogo,
            onChanged: (v) => setState(() => _receiptLogo = v ?? _receiptLogo),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderNumber,
            value: _receiptOrderNumber,
            onChanged: (v) =>
                setState(() => _receiptOrderNumber = v ?? _receiptOrderNumber),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderDate,
            value: _receiptOrderDate,
            onChanged: (v) =>
                setState(() => _receiptOrderDate = v ?? _receiptOrderDate),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAddress,
            value: _receiptAddress,
            onChanged: (v) =>
                setState(() => _receiptAddress = v ?? _receiptAddress),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingCashierAndUser,
            value: _receiptCashierAndUser,
            onChanged: (v) => setState(
                () => _receiptCashierAndUser = v ?? _receiptCashierAndUser),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAdjusmentAmount,
            value: _receiptAdjusmentAmount,
            onChanged: (v) => setState(
                () => _receiptAdjusmentAmount = v ?? _receiptAdjusmentAmount),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingTax,
            value: _receiptTax,
            onChanged: (v) => setState(() => _receiptTax = v ?? _receiptTax),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingServiceCharge,
            value: _receiptServiceCharge,
            onChanged: (v) => setState(
                () => _receiptServiceCharge = v ?? _receiptServiceCharge),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingProductUnitPrice,
            value: _receiptProductUnitPrice,
            onChanged: (v) => setState(
                () => _receiptProductUnitPrice = v ?? _receiptProductUnitPrice),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingModifierUnitPrice,
            value: _receiptModifierUnitPrice,
            onChanged: (v) => setState(() =>
                _receiptModifierUnitPrice = v ?? _receiptModifierUnitPrice),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
