import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/section_views/account/bloc/setting_account_bloc.dart';
import 'package:pos/features/settings/presentation/section_views/account/widgets/setting_change_pin_dialog.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/services/popup_service.dart';

/// Account Settings section view.
///
/// Displays:
/// - Current user name
/// - "Change Pin" button
class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  void _showChangePinDialog(BuildContext context) {
    final bloc = context.read<SettingAccountBloc>();
    showDialog<void>(
      context: context,
      builder: (_) => SettingChangePinDialog(
        onSubmit: (oldPin, newPin) {
          bloc.add(
            SettingAccountChangePinSubmitted(oldPin: oldPin, newPin: newPin),
          );
        },
      ),
    );
  }

  String _errorMessage(AppLocalizations l10n, SettingAccountState state) {
    switch (state.error) {
      case SettingAccountError.userNotFound:
        return l10n.err_userNotFound;
      case SettingAccountError.oldPinInvalid:
        return l10n.err_oldPinInvalid;
      case SettingAccountError.unknown:
      case null:
        return state.errorDetail ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<SettingAccountBloc, SettingAccountState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SettingAccountStatus.loading) {
          context.loaderOverlay.show();
          return;
        }
        context.loaderOverlay.hide();

        if (state.status == SettingAccountStatus.success) {
          locator<PopupService>().show(
            context,
            message: l10n.msg_pinChangedSuccess,
            type: PopupType.success,
          );
        } else if (state.status == SettingAccountStatus.failure) {
          locator<PopupService>().show(
            context,
            message: _errorMessage(l10n, state),
            type: PopupType.error,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SettingSectionTitle(title: l10n.title_settingAccount),
              const SizedBox(height: 24),

              // Name label
              Text(
                l10n.lbl_settingName,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              const SizedBox(height: 4),
              Text(state.userName, style: AppTextStyles.titleMedium),
              const SizedBox(height: 24),

              // Change Pin button
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 280,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => _showChangePinDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      l10n.btn_settingChangePin,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
