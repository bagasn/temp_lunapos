import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/domain/entities/setting_order_entity.dart';
import 'package:pos/features/settings/presentation/section_views/order/bloc/setting_order_bloc.dart';
import 'package:pos/features/settings/presentation/section_views/order/bloc/setting_order_event.dart';
import 'package:pos/features/settings/presentation/section_views/order/bloc/setting_order_state.dart';
import 'package:pos/features/settings/presentation/widgets/setting_checkbox_tile.dart';
import 'package:pos/features/settings/presentation/widgets/setting_number_input_field.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';

/// Order Settings section view.
///
/// Reads and persists all order-related settings via [SettingOrderBloc].
/// The BLoC is provided by the parent [SettingPage] to preserve state
/// across sidebar navigation.
class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OrderSectionContent();
  }
}

class _OrderSectionContent extends StatelessWidget {
  const _OrderSectionContent();

  static const _viewOptions = ['Order', 'Table', 'Queue'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingOrderBloc, SettingOrderState>(
      builder: (context, state) {
        if (state is SettingOrderInitial || state is SettingOrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SettingOrderError) {
          return Center(child: Text(state.message));
        }

        if (state is SettingOrderLoaded) {
          final settings = state.settings;

          void onChange(SettingOrderEntity updated) {
            context
                .read<SettingOrderBloc>()
                .add(OrderSettingsChanged(updated));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingSectionTitle(title: l10n.title_settingOrder),
                const SizedBox(height: 24),

                // ── Default View dropdown ──────────────────────────────
                Text(
                  l10n.lbl_settingDefaultView,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 320,
                  child: DropdownButtonFormField<int>(
                    // ignore: deprecated_member_use
                    value: settings.defaultView,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.borderLight),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.borderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    items: List.generate(
                      _viewOptions.length,
                      (i) => DropdownMenuItem(
                        value: i,
                        child: Text(_viewOptions[i],
                            style: AppTextStyles.bodyMedium),
                      ),
                    ),
                    onChanged: (val) {
                      if (val != null) {
                        onChange(settings.copyWith(defaultView: val));
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // ── Checkboxes ─────────────────────────────────────────
                SettingCheckboxTile(
                  title: l10n.lbl_settingCustomerRequired,
                  value: settings.customerRequired,
                  onChanged: (v) => onChange(
                    settings.copyWith(customerRequired: v ?? settings.customerRequired),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingShiftSessionRequired,
                  value: settings.shiftSessionRequired,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        shiftSessionRequired: v ?? settings.shiftSessionRequired),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingShowCashDetail,
                  value: settings.showCashDetail,
                  onChanged: (v) => onChange(
                    settings.copyWith(showCashDetail: v ?? settings.showCashDetail),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingRoundOrderTotal,
                  value: settings.roundOrderTotal,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        roundOrderTotal: v ?? settings.roundOrderTotal),
                  ),
                  expandedContent: _RoundingExpandedContent(
                    settings: settings,
                    onChange: onChange,
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingQueueNumbering,
                  value: settings.queueNumbering,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        queueNumbering: v ?? settings.queueNumbering),
                  ),
                  expandedContent: SettingNumberInputField(
                    label: l10n.lbl_settingMaxQueueNumber,
                    value: settings.maxQueueNumber,
                    width: double.infinity,
                    onSave: (v) =>
                        onChange(settings.copyWith(maxQueueNumber: v)),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingAddCustomNotes,
                  value: settings.addCustomNotes,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        addCustomNotes: v ?? settings.addCustomNotes),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingPrintKitchenSeparately,
                  value: settings.printKitchenSeparately,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        printKitchenSeparately:
                            v ?? settings.printKitchenSeparately),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingSyncOpenOrder,
                  value: settings.syncOpenOrder,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        syncOpenOrder: v ?? settings.syncOpenOrder),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingCashPayment,
                  value: settings.cashPayment,
                  onChanged: (v) => onChange(
                    settings.copyWith(cashPayment: v ?? settings.cashPayment),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingAllowSavingOrders,
                  value: settings.allowSavingOrders,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        allowSavingOrders: v ?? settings.allowSavingOrders),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingEndingShiftNotAllowed,
                  value: settings.endingShiftNotAllowed,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        endingShiftNotAllowed:
                            v ?? settings.endingShiftNotAllowed),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingTableSelectionRequired,
                  value: settings.tableSelectionRequired,
                  onChanged: (v) => onChange(
                    settings.copyWith(
                        tableSelectionRequired:
                            v ?? settings.tableSelectionRequired),
                  ),
                ),
                SettingCheckboxTile(
                  title: l10n.lbl_settingShowStock,
                  value: settings.showStock,
                  onChanged: (v) => onChange(
                    settings.copyWith(showStock: v ?? settings.showStock),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

/// Expanded content for "Round Order Total":
/// a rounding type dropdown + rounding base input with a Save button.
class _RoundingExpandedContent extends StatelessWidget {
  final SettingOrderEntity settings;
  final ValueChanged<SettingOrderEntity> onChange;

  const _RoundingExpandedContent({
    required this.settings,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Index = value stored in `roundingType` (0 = Up, 1 = Down, 2 = Nearest).
    final roundingTypeLabels = [
      l10n.lbl_settingRoundingUp,
      l10n.lbl_settingRoundingDown,
      l10n.lbl_settingRoundingNearest,
    ];

    final selectedType =
        settings.roundingType.clamp(0, roundingTypeLabels.length - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.lbl_settingRoundingType,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 420,
          child: DropdownButtonFormField<int>(
            // ignore: deprecated_member_use
            value: selectedType,
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
            items: List.generate(
              roundingTypeLabels.length,
              (i) => DropdownMenuItem(
                value: i,
                child: Text(
                  roundingTypeLabels[i],
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ),
            onChanged: (val) {
              if (val != null) onChange(settings.copyWith(roundingType: val));
            },
          ),
        ),
        const SizedBox(height: 8),
        SettingNumberInputField(
          value: settings.roundingBase,
          prefixText: 'Rp ',
          onSave: (v) => onChange(settings.copyWith(roundingBase: v)),
        ),
      ],
    );
  }
}
