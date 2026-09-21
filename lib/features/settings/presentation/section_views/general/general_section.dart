import 'package:flutter/material.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_checkbox_tile.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';

/// General Settings section view.
///
/// Displays:
/// - App lock checkbox with description
/// - Select Language dropdown
class GeneralSection extends StatefulWidget {
  const GeneralSection({super.key});

  @override
  State<GeneralSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  bool _appLock = true;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Indonesia'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            value: _appLock,
            onChanged: (val) => setState(() => _appLock = val ?? _appLock),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.lbl_settingSelectLanguage,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 320,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedLanguage,
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
              items: _languages
                  .map(
                    (lang) => DropdownMenuItem(
                      value: lang,
                      child: Text(lang, style: AppTextStyles.bodyMedium),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedLanguage = val);
              },
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.borderLight),
        ],
      ),
    );
  }
}
