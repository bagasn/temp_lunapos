// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'printer_setup_cubit.dart';

class PrinterSetupState extends Equatable {
  final List<DropdownItemModel> printerTypes;
  final DropdownItemModel selectedType;

  final List<DropdownItemModel> printerModules;
  final DropdownItemModel? selectedModule;

  final List<DropdownItemModel> paperSizes;
  final DropdownItemModel? selectedPaperSize;

  final List<PrinterDevice> printerDevices;
  PrinterDevice? selectedDevice;

  final int feedAfterPrint;
  final bool isAutoCut;
  final bool disconnectAfterPrint;
  final int copyPrint;
  final bool autoPrintOnPayment;

  final bool isLoading;

  PrinterSetupState({
    required this.printerTypes,
    required this.selectedType,
    required this.printerModules,
    required this.selectedModule,
    required this.paperSizes,
    required this.selectedPaperSize,
    required this.printerDevices,
    required this.selectedDevice,
    required this.feedAfterPrint,
    required this.isAutoCut,
    required this.disconnectAfterPrint,
    required this.copyPrint,
    required this.autoPrintOnPayment,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [
    ...printerTypes,
    selectedType,
    ...printerModules,
    selectedModule,
    ...paperSizes,
    selectedPaperSize,
    selectedDevice,
    feedAfterPrint,
    isAutoCut,
    disconnectAfterPrint,
    copyPrint,
    autoPrintOnPayment,
    isLoading,
    ...printerDevices,
  ];

  PrinterSetupState copyWith({
    List<DropdownItemModel>? printerTypes,
    DropdownItemModel? selectedType,
    List<DropdownItemModel>? printerModules,
    DropdownItemModel? selectedModule,
    List<DropdownItemModel>? paperSizes,
    DropdownItemModel? selectedPaperSize,
    List<PrinterDevice>? printerDevices,
    PrinterDevice? selectedDevice,
    int? feedAfterPrint,
    bool? isAutoCut,
    bool? disconnectAfterPrint,
    int? copyPrint,
    bool? autoPrintOnPayment,
    bool? isLoading,
  }) {
    return PrinterSetupState(
      printerTypes: printerTypes ?? this.printerTypes,
      selectedType: selectedType ?? this.selectedType,
      printerModules: printerModules ?? this.printerModules,
      selectedModule: selectedModule ?? this.selectedModule,
      paperSizes: paperSizes ?? this.paperSizes,
      selectedPaperSize: selectedPaperSize ?? this.selectedPaperSize,
      printerDevices: printerDevices ?? this.printerDevices,
      selectedDevice: selectedDevice ?? this.selectedDevice,
      feedAfterPrint: feedAfterPrint ?? this.feedAfterPrint,
      isAutoCut: isAutoCut ?? this.isAutoCut,
      disconnectAfterPrint: disconnectAfterPrint ?? this.disconnectAfterPrint,
      copyPrint: copyPrint ?? this.copyPrint,
      autoPrintOnPayment: autoPrintOnPayment ?? this.autoPrintOnPayment,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  void remotePrinterDevice() {
    selectedDevice = null;
  }

  @override
  bool get stringify => true;
}
