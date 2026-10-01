import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_checkbox_tile.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

import 'package:pos/features/settings/presentation/section_views/general/bloc/setting_general_bloc.dart';
import 'package:pos/features/settings/presentation/section_views/general/bloc/setting_general_event.dart';
import 'package:pos/features/settings/presentation/section_views/general/bloc/setting_general_state.dart';

/// General Settings section view.
///
/// Displays:
/// - App lock checkbox with description
/// - Select Language dropdown
class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _GeneralSectionContent();
  }
}

class _GeneralSectionContent extends StatelessWidget {
  const _GeneralSectionContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final Map<String, String> languageMap = {
      'en': 'English',
      'id': 'Indonesia',
    };

    return BlocBuilder<SettingGeneralBloc, SettingGeneralState>(
      builder: (context, state) {
        if (state is SettingGeneralLoading || state is SettingGeneralInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingGeneralError) {
          return Center(child: Text(state.message));
        } else if (state is SettingGeneralLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingSectionTitle(title: l10n.title_settingGeneral),
                const SizedBox(height: 24),
                SettingCheckboxTile(
                  title: l10n.lbl_settingAppLock,
                  description: l10n.desc_settingAppLock,
                  value: state.isAutoLock,
                  onChanged: (val) {
                    if (val != null) {
                      context.read<SettingGeneralBloc>().add(
                            SettingGeneralAutoLockChanged(isAutoLock: val),
                          );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.lbl_settingSelectLanguage,
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 320,
                  // ignore: deprecated_member_use
                  child: DropdownButtonFormField<String>(
                    value: state.currentLocaleCode,
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
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 2),
                      ),
                    ),
                    items: languageMap.entries
                        .map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value,
                                style: AppTextStyles.bodyMedium),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        context.read<SettingGeneralBloc>().add(
                              SettingGeneralLocaleChanged(newLocaleCode: val),
                            );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(color: AppColors.borderLight),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
