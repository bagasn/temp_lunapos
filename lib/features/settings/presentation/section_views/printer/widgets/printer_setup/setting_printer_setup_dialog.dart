import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/section_views/printer/widgets/printer_setup/cubit/printer_setup_cubit.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/domain/entities/printer/printer_device.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:pos/shared/services/popup_service.dart';
import 'package:pos/shared/utilities/input_formatter/decimal_formatter.dart';
import 'package:pos/shared/utilities/regex_util.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_input_model.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_menu_field.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_text_field.dart';
import 'package:pos/shared/widgets/widgets/text_field/text_field.dart';
import 'package:pos/shared/widgets/widgets/text_field/text_form_field.dart';

class SettingPrinterSetupDialog extends StatelessWidget {
  final String printerAreaId;
  final void Function() onSubmitted;

  const SettingPrinterSetupDialog({
    super.key,
    required this.printerAreaId,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<PrinterSetupCubit>(),
      child: _SettingPrinterSetupDialog(
        printerAreaId: printerAreaId,
        onSubmitted: onSubmitted,
      ),
    );
  }
}

class _SettingPrinterSetupDialog extends StatefulWidget {
  final String printerAreaId;
  final void Function() onSubmitted;

  const _SettingPrinterSetupDialog({
    required this.printerAreaId,
    required this.onSubmitted,
  });

  @override
  State<_SettingPrinterSetupDialog> createState() =>
      _SettingPrinterSetupDialogState();
}

class _SettingPrinterSetupDialogState
    extends State<_SettingPrinterSetupDialog> {
  final _feedController = TextEditingController(text: '0');
  final _ipAddressController = TextEditingController();

  Widget _labeled(String label, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMedium),
      ),
      const SizedBox(height: 8),
      child,
    ],
  );

  Widget _stepButton(IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.textWhite),
    ),
  );

  Widget _buildPrinterDeviceView(
    String label, {
    required PrinterSetupState state,
  }) {
    DropdownInputModel? printerDevice;
    if (state.selectedDevice != null) {
      printerDevice = DropdownInputModel(
        mainValue: state.selectedDevice!.printerName,
        subValues: [state.selectedDevice!.printerAddress],
      );
    }

    Widget widget;
    if (state.selectedModule?.id == SettingPrinterModule.escposNetwork.name) {
      widget = AppTextField(
        controller: _ipAddressController,
        constraints: BoxConstraints(minHeight: 54),
        hintText: '192.168.xxx.xxx',
        maxLength: 15,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      );
    } else {
      widget = AppDropdownTextField(
        value: printerDevice,
        hintText: 'Pilih Perangkat Printer',
        enabled: state.selectedModule != null,
        onPressed: () {
          context.read<PrinterSetupCubit>().onRequestPrinterDevices();
        },
      );
    }

    return _labeled(label, widget);
  }

  @override
  Widget build(BuildContext mContext) {
    final l10n = AppLocalizations.of(mContext)!;

    return LoaderOverlay(
      child: BlocConsumer<PrinterSetupCubit, PrinterSetupState>(
        listener: (context, state) {
          if (state.viewState == PrinterSetupViewState.loading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (state.viewState == PrinterSetupViewState.printerSaved) {
            widget.onSubmitted();
            if (context.canPop()) {
              context.pop();
            }
            return;
          }

          if (state.selectedModule?.id !=
              SettingPrinterModule.escposNetwork.name) {
            _ipAddressController.clear();
          }
        },
        builder: (context, state) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: Text(
                      l10n.title_settingSelectPrinter,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _labeled(
                                  l10n.lbl_settingPrinterType,
                                  AppDropdownMenuField(
                                    menuItems: state.printerTypes,
                                    value: state.selectedType,
                                    onChange: (value) {
                                      context
                                          .read<PrinterSetupCubit>()
                                          .onChangeDropdownValue(
                                            printerType: value,
                                          );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _labeled(
                                  l10n.lbl_settingPrinterModule,
                                  AppDropdownMenuField(
                                    menuItems: state.printerModules,
                                    value: state.selectedModule,
                                    hintText: 'Pilih Module Printer',
                                    onChange: (value) {
                                      context
                                          .read<PrinterSetupCubit>()
                                          .onChangeDropdownValue(
                                            printerModule: value,
                                          );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: _buildPrinterDeviceView(
                              'Printer',
                              state: state,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _labeled(
                                  l10n.lbl_settingPaperSize,
                                  AppDropdownMenuField(
                                    menuItems: state.paperSizes,
                                    value: state.selectedPaperSize,
                                    onChange: (value) {
                                      context
                                          .read<PrinterSetupCubit>()
                                          .onChangeDropdownValue(
                                            paperSize: value,
                                          );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _labeled(
                                  l10n.lbl_settingFeedAfterPrint,
                                  AppTextFormField(
                                    controller: _feedController,
                                    constraints: BoxConstraints(minHeight: 54),
                                    hintText: 'Nilai Feed Line',
                                    maxLength: 2,
                                    inputFormatters: [
                                      ThousandsDecimalFormatter(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                value: state.isAutoCut,
                                activeColor: AppColors.primary,
                                onChanged: (value) {
                                  context
                                      .read<PrinterSetupCubit>()
                                      .onChangeCheckboxValue(isAutoCut: value);
                                },
                              ),
                              Text(
                                'Auto Cut After Print',
                                style: AppTextStyles.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: state.disconnectAfterPrint,
                                activeColor: AppColors.primary,
                                onChanged: (value) {
                                  context
                                      .read<PrinterSetupCubit>()
                                      .onChangeCheckboxValue(
                                        isDisconnectAfterPrint: value,
                                      );
                                },
                              ),
                              Text(
                                l10n.lbl_settingDisconnectAfterPrint,
                                style: AppTextStyles.bodyMedium,
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.info_outline, size: 24),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                l10n.lbl_settingNumberOfCopies,
                                style: AppTextStyles.bodyMedium,
                              ),
                              const SizedBox(width: 16),
                              _stepButton(Icons.remove, () {
                                context
                                    .read<PrinterSetupCubit>()
                                    .onAddCopyValue(-1);
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  '${state.copyPrint}',
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              _stepButton(Icons.add, () {
                                context
                                    .read<PrinterSetupCubit>()
                                    .onAddCopyValue(1);
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(
                                value: state.autoPrintOnPayment,
                                activeColor: AppColors.primary,
                                onChanged: (value) {
                                  context
                                      .read<PrinterSetupCubit>()
                                      .onChangeCheckboxValue(
                                        isAutoPrintOnPayment: value,
                                      );
                                },
                              ),
                              Expanded(
                                child: Text(
                                  l10n.lbl_settingAutoPrintReceipt,
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(l10n.btn_cancel),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: ElevatedButton(
                                    // UI only: Save is disabled until a printer is picked.
                                    onPressed: state.btnSaveEnabled
                                        ? () {
                                            _onSaveConfig(context, state);
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.textWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(l10n.btn_save),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSaveConfig(BuildContext context, PrinterSetupState state) async {
    PrinterDevice? printerDevice = state.selectedDevice;

    if (state.selectedModule?.id == SettingPrinterModule.escposNetwork.name) {
      final ipAddress = _ipAddressController.text;
      if (!RegexUtil.isValidIpv4(ipAddress)) {
        locator<PopupService>().show(
          context,
          message: 'Invalid IP Address',
          type: PopupType.error,
        );
        return;
      }

      printerDevice = PrinterDevice(
        printerAddress: ipAddress,
        printerName: ipAddress,
      );
    }

    context.read<PrinterSetupCubit>().onSavePrinterConfig(
      printerAreaId: widget.printerAreaId,
      printerDevice: printerDevice,
    );
  }
}
