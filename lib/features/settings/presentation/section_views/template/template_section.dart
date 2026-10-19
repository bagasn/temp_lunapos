import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/section_views/template/bloc/setting_template_bloc.dart';
import 'package:pos/features/settings/presentation/section_views/template/bloc/setting_template_event.dart';
import 'package:pos/features/settings/presentation/section_views/template/bloc/setting_template_state.dart';
import 'package:pos/features/settings/presentation/widgets/setting_checkbox_tile.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/features/settings/domain/entities/setting_template_entity.dart';

/// Template Settings section view.
///
/// Displays two sub-groups: Bill and Receipt, each with the same
/// set of template element checkboxes.
class TemplateSection extends StatelessWidget {
  const TemplateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingTemplateBloc, SettingTemplateState>(
      listener: (context, state) {
        if (state is SettingTemplateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is SettingTemplateLoaded) {
          return _TemplateSectionContent(settings: state.settings);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _TemplateSectionContent extends StatelessWidget {
  final SettingTemplateEntity settings;

  const _TemplateSectionContent({required this.settings});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    void onBillChange(PrintoutTemplateItem bill) {
      context.read<SettingTemplateBloc>().add(UpdateBillTemplate(bill));
    }

    void onReceiptChange(PrintoutTemplateItem receipt) {
      context.read<SettingTemplateBloc>().add(UpdateReceiptTemplate(receipt));
    }

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
            value: settings.bill.showLogo,
            onChanged: (v) => onBillChange(settings.bill.copyWith(showLogo: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderNumber,
            value: settings.bill.showOrderNumber,
            onChanged: (v) =>
                onBillChange(settings.bill.copyWith(showOrderNumber: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderDate,
            value: settings.bill.showDate,
            onChanged: (v) =>
                onBillChange(settings.bill.copyWith(showDate: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAddress,
            value: settings.bill.showAddress,
            onChanged: (v) => onBillChange(settings.bill.copyWith(showAddress: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingCashierAndUser,
            value: settings.bill.showCashierAndUser,
            onChanged: (v) =>
                onBillChange(settings.bill.copyWith(showCashierAndUser: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAdjusmentAmount,
            value: settings.bill.showAdjustment,
            onChanged: (v) => onBillChange(
                settings.bill.copyWith(showAdjustment: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingTax,
            value: settings.bill.showTax,
            onChanged: (v) => onBillChange(settings.bill.copyWith(showTax: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingServiceCharge,
            value: settings.bill.showServiceCharge,
            onChanged: (v) =>
                onBillChange(settings.bill.copyWith(showServiceCharge: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingProductUnitPrice,
            value: settings.bill.showUnitPriceProduct,
            onChanged: (v) => onBillChange(
                settings.bill.copyWith(showUnitPriceProduct: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingModifierUnitPrice,
            value: settings.bill.showUnitPriceModifier,
            onChanged: (v) => onBillChange(
                settings.bill.copyWith(showUnitPriceModifier: v)),
          ),
          const SizedBox(height: 24),

          // Receipt sub-section
          Text(l10n.lbl_settingReceipt, style: AppTextStyles.titleLarge),
          const SizedBox(height: 12),
          SettingCheckboxTile(
            title: l10n.lbl_settingLogo,
            value: settings.receipt.showLogo,
            onChanged: (v) => onReceiptChange(settings.receipt.copyWith(showLogo: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderNumber,
            value: settings.receipt.showOrderNumber,
            onChanged: (v) =>
                onReceiptChange(settings.receipt.copyWith(showOrderNumber: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingOrderDate,
            value: settings.receipt.showDate,
            onChanged: (v) =>
                onReceiptChange(settings.receipt.copyWith(showDate: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAddress,
            value: settings.receipt.showAddress,
            onChanged: (v) =>
                onReceiptChange(settings.receipt.copyWith(showAddress: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingCashierAndUser,
            value: settings.receipt.showCashierAndUser,
            onChanged: (v) => onReceiptChange(
                settings.receipt.copyWith(showCashierAndUser: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingAdjusmentAmount,
            value: settings.receipt.showAdjustment,
            onChanged: (v) => onReceiptChange(
                settings.receipt.copyWith(showAdjustment: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingTax,
            value: settings.receipt.showTax,
            onChanged: (v) => onReceiptChange(settings.receipt.copyWith(showTax: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingServiceCharge,
            value: settings.receipt.showServiceCharge,
            onChanged: (v) => onReceiptChange(
                settings.receipt.copyWith(showServiceCharge: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingProductUnitPrice,
            value: settings.receipt.showUnitPriceProduct,
            onChanged: (v) => onReceiptChange(
                settings.receipt.copyWith(showUnitPriceProduct: v)),
          ),
          SettingCheckboxTile(
            title: l10n.lbl_settingModifierUnitPrice,
            value: settings.receipt.showUnitPriceModifier,
            onChanged: (v) => onReceiptChange(
                settings.receipt.copyWith(showUnitPriceModifier: v)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
