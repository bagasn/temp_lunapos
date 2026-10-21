import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/section_views/printer/bloc/setting_printer_bloc.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/features/settings/presentation/widgets/setting_printer_row.dart';
import 'package:pos/features/settings/presentation/section_views/printer/widgets/printer_setup/setting_printer_setup_dialog.dart';
import 'package:pos/features/settings/presentation/widgets/setting_section_title.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:pos/shared/services/popup_service.dart';
import 'package:pos/shared/widgets/dialog/input_text_dialog.dart';

class PrinterSection extends StatelessWidget {
  const PrinterSection({super.key});

  void _showSetupDialog(
    BuildContext context, {
    required String printerAreaId,
    required void Function() onSubmitted,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) => SettingPrinterSetupDialog(
        printerAreaId: printerAreaId,
        onSubmitted: onSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<SettingPrinterBloc, SettingPrinterState>(
      listener: (context, state) {
        if (state.stateView == SettingPrinterStateView.loading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
        if (state.errorMessage != null) {
          locator<PopupService>().show(
            context,
            message: state.errorMessage!,
            type: PopupType.error,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SettingSectionTitle(title: l10n.title_settingPrinter),
              const SizedBox(height: 24),

              _buildPrinterAreaView(
                context,
                state,
                onPressed: (printerAreaId) {
                  _showSetupDialog(
                    context,
                    printerAreaId: printerAreaId,
                    onSubmitted: () {
                      context.read<SettingPrinterBloc>().add(
                        SettingPrinterLoaded(),
                      );
                    },
                  );
                },
                onTestPrint: (label, module, config) {
                  context.read<SettingPrinterBloc>().add(
                    SettingPrinterTestPrintStarted(
                      printerAreaLabel: label,
                      printerModule: module,
                      printerConfig: config,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Add Printer Area button
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAddPrinterAreaDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(220, 52),
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: AppColors.textWhite),
                  label: Text(
                    l10n.btn_settingAddPrinterArea,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textWhite,
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

  Widget _buildPrinterAreaView(
    BuildContext context,
    SettingPrinterState state, {
    Function(String printerAreaId)? onPressed,
    Function(String label, SettingPrinterModule module, PrinterConfig config)?
    onTestPrint,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        for (final printer in state.printers)
          SettingPrinterRow(
            label: printer.label,
            printerConfig: printer.printerConfig,
            onTestPrint: () {
              if (onTestPrint != null) {
                if (printer.printerModule != null &&
                    printer.printerConfig != null) {
                  onTestPrint(
                    printer.label,
                    printer.printerModule!,
                    printer.printerConfig!,
                  );
                }
              }
            },
            onTap: () {
              if (onPressed != null) {
                onPressed(printer.id);
              }
            },
          ),
      ],
    );
  }

  void _showAddPrinterAreaDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => InputTextDialog(
        title: 'Tambah Printer Area',
        labelText: 'Nama Printer Area',
        hintText: 'Masukan nama printer area',
        onSubmit: (value) {
          context.read<SettingPrinterBloc>().add(
            SettingPrinterNewAreaAdded(value),
          );
        },
      ),
    );
  }
}
