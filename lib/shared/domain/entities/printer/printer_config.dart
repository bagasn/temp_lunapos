// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'printer_config.g.dart';

@JsonSerializable()
class PrinterConfig {
  final int paperSize;
  final double feedAfterPrint;
  final bool isAutoCut;
  final int copyNumber;
  final bool disconnectAfterPrint;
  final PrinterDevice printer;

  PrinterConfig({
    required this.paperSize,
    required this.feedAfterPrint,
    required this.isAutoCut,
    required this.copyNumber,
    required this.disconnectAfterPrint,
    required this.printer,
  });

  factory PrinterConfig.formJson(Map<String, dynamic> json) =>
      _$PrinterConfigFromJson(json);

  Map<String, dynamic> toMap() => _$PrinterConfigToJson(this);
}

@JsonSerializable()
class PrinterDevice {
  final String printerAddress;
  final String printerName;
  final String? vendorId;
  final String? productId;

  PrinterDevice({
    required this.printerAddress,
    required this.printerName,
    this.vendorId,
    this.productId,
  });

  factory PrinterDevice.fromJson(Map<String, dynamic> json) =>
      _$PrinterDeviceFromJson(json);

  Map<String, dynamic> toMap() => _$PrinterDeviceToJson(this);
}
