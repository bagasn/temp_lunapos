import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_checkbox_tile.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Order Settings section view.
///
/// Displays:
/// - Default View dropdown
/// - List of order-related checkboxes (13 items)
class OrderSection extends StatefulWidget {
  const OrderSection({super.key});

  @override
  State<OrderSection> createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  String _defaultView = 'Order';

  bool _customerRequired = false;
  bool _shiftSessionRequired = false;
  bool _showCashDetail = true;
  bool _roundOrderTotal = false;
  bool _queueNumbering = false;
  bool _addCustomNotes = false;
  bool _printKitchenSeparately = false;
  bool _syncOpenOrder = false;
  bool _cashPayment = true;
  bool _allowSavingOrders = true;
  bool _endingShiftNotAllowed = false;
  bool _tableSelectionRequired = false;
  bool _showStock = false;

  final List<String> _defaultViewOptions = ['Order', 'Table', 'Queue'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingSectionTitle(title: l10n.title_settingOrder),
          const SizedBox(height: 24),

          // Default View dropdown
          Text(
            l10n.lbl_settingDefaultView,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 320,
            child: DropdownButtonFormField<String>(
              initialValue: _defaultView,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              items: _defaultViewOptions
                  .map(
                    (opt) => DropdownMenuItem(
                      value: opt,
                      child: Text(opt, style: AppTextStyles.bodyMedium),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _defaultView = val);
              },
            ),
          ),
          const SizedBox(height: 20),

          // Checkboxes
          SettingCheckboxTile(
            title: l10n.lbl_settingCustomerRequired,
            value: _customerRequired,
            onChanged: (v) =>
                setState(() => _customerRequired = v ?? _customerRequired),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingShiftSessionRequired,
            value: _shiftSessionRequired,
            onChanged: (v) => setState(
                () => _shiftSessionRequired = v ?? _shiftSessionRequired),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingShowCashDetail,
            value: _showCashDetail,
            onChanged: (v) =>
                setState(() => _showCashDetail = v ?? _showCashDetail),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingRoundOrderTotal,
            value: _roundOrderTotal,
            onChanged: (v) =>
                setState(() => _roundOrderTotal = v ?? _roundOrderTotal),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingQueueNumbering,
            value: _queueNumbering,
            onChanged: (v) =>
                setState(() => _queueNumbering = v ?? _queueNumbering),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAddCustomNotes,
            value: _addCustomNotes,
            onChanged: (v) =>
                setState(() => _addCustomNotes = v ?? _addCustomNotes),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingPrintKitchenSeparately,
            value: _printKitchenSeparately,
            onChanged: (v) => setState(
                () => _printKitchenSeparately = v ?? _printKitchenSeparately),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingSyncOpenOrder,
            value: _syncOpenOrder,
            onChanged: (v) =>
                setState(() => _syncOpenOrder = v ?? _syncOpenOrder),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingCashPayment,
            value: _cashPayment,
            onChanged: (v) =>
                setState(() => _cashPayment = v ?? _cashPayment),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAllowSavingOrders,
            value: _allowSavingOrders,
            onChanged: (v) =>
                setState(() => _allowSavingOrders = v ?? _allowSavingOrders),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingEndingShiftNotAllowed,
            value: _endingShiftNotAllowed,
            onChanged: (v) => setState(
                () => _endingShiftNotAllowed = v ?? _endingShiftNotAllowed),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingTableSelectionRequired,
            value: _tableSelectionRequired,
            onChanged: (v) => setState(
                () => _tableSelectionRequired = v ?? _tableSelectionRequired),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingShowStock,
            value: _showStock,
            onChanged: (v) => setState(() => _showStock = v ?? _showStock),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
