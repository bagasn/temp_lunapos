import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/navigation/app_route_paths.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/section_views/system/bloc/setting_system_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/widgets/dialog/confirmation_dialog.dart';

/// System Settings section view.
///
/// Displays a two-column layout:
/// - Left: Outlet, Connection mode, Sync, Backup & Restore rows
/// - Right: QR code card (IP address) and Version card
class SystemSection extends StatelessWidget {
  const SystemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<SettingSystemBloc, SettingSystemState>(
      listenWhen: (previous, current) =>
          !previous.isRedirectToSelectOutlet && current.isRedirectToSelectOutlet,
      listener: (context, state) {
        context.go(AppRoutePaths.selectOutlet.path);
      },
      builder: (context, state) => _buildContent(context, l10n, state),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    SettingSystemState state,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingSectionTitle(title: l10n.title_settingSystem),
                const SizedBox(height: 24),

                // Outlet row
                _SystemRow(
                  label: l10n.lbl_settingOutlet,
                  value: state.outletName,
                  actionButton: OutlinedButton.icon(
                    onPressed: () async {
                      final confirm = await showConfirmationDialog(
                        context: context,
                        message: l10n.txt_logoutConfirmation,
                      );
                      if (confirm == true && context.mounted) {
                        context.read<SettingSystemBloc>().add(
                          SettingSystemChangeOutletConfirmed(),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.sync_alt, size: 18),
                    label: Text(
                      l10n.btn_settingChangeOutlet,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const Divider(color: AppColors.borderLight, height: 32),

                // Sync row
                _SystemRow(
                  label: l10n.lbl_settingSync,
                  valueWidget: Row(
                    children: [
                      Text(
                        l10n.lbl_settingLastSynchronized,
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '21/09/2026   17:10:22',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  actionButton: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textWhite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(
                      l10n.btn_settingSync,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
                const Divider(color: AppColors.borderLight, height: 32),

                // Backup & Restore row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.lbl_settingBackupRestore,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.lbl_settingBackupData,
                            style: AppTextStyles.titleMedium,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                          icon: const Icon(
                            Icons.cloud_upload_outlined,
                            size: 18,
                          ),
                          label: Text(
                            l10n.btn_settingBackupDataOffline,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.lbl_settingRestoreData,
                            style: AppTextStyles.titleMedium,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                          icon: const Icon(Icons.restore_outlined, size: 18),
                          label: Text(
                            l10n.btn_settingRestoreData,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Version card
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.charcoal50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'VERSION ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textMedium,
                          ),
                        ),
                        TextSpan(
                          text: state.appVersion,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}

/// Internal helper widget for a system setting row.
class _SystemRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;
  final Widget actionButton;

  const _SystemRow({
    required this.label,
    this.value,
    this.valueWidget,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              const SizedBox(height: 4),
              if (valueWidget != null)
                valueWidget!
              else
                Text(value ?? '', style: AppTextStyles.titleMedium),
            ],
          ),
        ),
        const SizedBox(width: 16),
        actionButton,
      ],
    );
  }
}
