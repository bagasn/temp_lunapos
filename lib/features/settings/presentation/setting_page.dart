import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/section_views/account/account_section.dart';
import 'package:pos/features/settings/presentation/section_views/dual_display/dual_display_section.dart';
import 'package:pos/features/settings/presentation/section_views/general/general_section.dart';
import 'package:pos/features/settings/presentation/section_views/order/order_section.dart';
import 'package:pos/features/settings/presentation/section_views/printer/printer_section.dart';
import 'package:pos/features/settings/presentation/section_views/scanner/scanner_section.dart';
import 'package:pos/features/settings/presentation/section_views/system/system_section.dart';
import 'package:pos/features/settings/presentation/section_views/template/template_section.dart';
import 'package:pos/features/settings/presentation/widgets/setting_sidebar_item.dart';
import 'package:pos/l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingView();
  }
}

class _SettingView extends StatefulWidget {
  const _SettingView();

  @override
  State<_SettingView> createState() => __SettingViewState();
}

class __SettingViewState extends State<_SettingView> {
  int _selectedIndex = 0;

  static const List<Widget> _sections = [
    GeneralSection(),
    OrderSection(),
    TemplateSection(),
    PrinterSection(),
    SystemSection(),
    AccountSection(),
    ScannerSection(),
    DualDisplaySection(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<({IconData icon, String title})> menuItems = [
      (icon: Icons.settings_outlined, title: l10n.lbl_settingGeneral),
      (icon: Icons.shopping_basket_outlined, title: l10n.lbl_settingOrder),
      (icon: Icons.table_chart_outlined, title: l10n.lbl_settingTemplate),
      (icon: Icons.print_outlined, title: l10n.lbl_settingPrinter),
      (icon: Icons.tune_outlined, title: l10n.lbl_settingSystem),
      (icon: Icons.person_outline, title: l10n.lbl_settingAccount),
      (icon: Icons.qr_code_scanner_outlined, title: l10n.lbl_settingScanner),
      (
        icon: Icons.desktop_windows_outlined,
        title: l10n.lbl_settingDualDisplay,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(title: Text('Setting')),
      body: Row(
        children: [
          // ─── Left Sidebar ───────────────────────────────────────
          Container(
            width: 240,
            color: AppColors.backgroundWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Menu items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return SettingSidebarItem(
                        icon: item.icon,
                        title: item.title,
                        isSelected: _selectedIndex == index,
                        onTap: () => setState(() => _selectedIndex = index),
                      );
                    },
                  ),
                ),

                // Exit button
                const Divider(height: 1, color: AppColors.borderLight),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.exit_to_app,
                          color: AppColors.statusError,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.btn_exit,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.statusError,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── Vertical Divider ───────────────────────────────────
          const VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.borderLight,
          ),

          // ─── Main Content Area ──────────────────────────────────
          Expanded(
            child: Container(
              color: AppColors.backgroundWhite,
              alignment: Alignment.topCenter,
              child: _sections[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
