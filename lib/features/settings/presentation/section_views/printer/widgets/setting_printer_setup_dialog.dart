import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos/core/di/injection_container.dart';
import 'package:pos/core/theme/app_text_styles.dart';
import 'package:pos/features/settings/presentation/section_views/printer/widgets/cubit/printer_setup_cubit.dart';
import 'package:pos/generated/colors.gen.dart';
import 'package:pos/l10n/app_localizations.dart';
import 'package:pos/shared/data/models/dropdown_item_model.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_input_model.dart';
import 'package:pos/shared/widgets/widgets/dropdown/dropdown_text_field.dart';

class SettingPrinterSetupDialog extends StatelessWidget {
  const SettingPrinterSetupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<PrinterSetupCubit>(),
      child: _SettingPrinterSetupDialog(),
    );
  }
}

class _SettingPrinterSetupDialog extends StatefulWidget {
  const _SettingPrinterSetupDialog();

  @override
  State<_SettingPrinterSetupDialog> createState() =>
      _SettingPrinterSetupDialogState();
}

class _SettingPrinterSetupDialogState
    extends State<_SettingPrinterSetupDialog> {
  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
  );

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

  Widget _dropdown({
    required DropdownItemModel? value,
    required List<DropdownItemModel> items,
    required ValueChanged<DropdownItemModel?> onChanged,
    String hint = '',
    VoidCallback? onTap,
  }) {
    return DropdownButtonFormField<DropdownItemModel>(
      initialValue: value,
      isExpanded: true,
      decoration: _decoration(hint),
      items: items
          .map(
            (value) =>
                DropdownMenuItem(value: value, child: Text(value.display)),
          )
          .toList(),
      onChanged: onChanged,
      onTap: onTap,
    );
  }

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

  @override
  Widget build(BuildContext mContext) {
    final l10n = AppLocalizations.of(mContext)!;

    return LoaderOverlay(
      child: BlocConsumer<PrinterSetupCubit, PrinterSetupState>(
        listener: (context, state) {
          if (state.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          DropdownItemModel? printerDevice;
          if (state.selectedDevice != null) {
            printerDevice = DropdownItemModel(
              id: state.selectedDevice!.printerAddress,
              display: state.selectedDevice!.printerName,
            );
          }

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
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _labeled(
                                  l10n.lbl_settingPrinterType,
                                  _dropdown(
                                    value: state.selectedType,
                                    items: state.printerTypes,
                                    onChanged: (value) {
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
                                  _dropdown(
                                    value: state.selectedModule,
                                    items: state.printerModules,
                                    onChanged: (value) {
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
                          const SizedBox(height: 16),
                          // _labeled(
                          //   l10n.lbl_settingPrinterItem,
                          //   _dropdown(
                          //     value: printerDevice,
                          //     items: [],
                          //     hint: l10n.lbl_settingSelectItem,
                          //     onChanged: (value) {},
                          //     onTap: () {},
                          //   ),
                          // ),
                          AppDropdownTextField(
                            label: 'Printer',

                            value: state.selectedDevice != null
                                ? DropdownInputModel(
                                    mainValue:
                                        state.selectedDevice!.printerName,
                                  )
                                : null,
                            onPressed: () {
                              context
                                  .read<PrinterSetupCubit>()
                                  .onRequestPrinterDevices();
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _labeled(
                                  l10n.lbl_settingPaperSize,
                                  _dropdown(
                                    value: state.selectedPaperSize,
                                    items: state.paperSizes,
                                    onChanged: (value) {
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
                                  TextFormField(
                                    initialValue: '0',
                                    keyboardType: TextInputType.number,
                                    decoration: _decoration(''),
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
                                    onPressed: () {},
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
}
