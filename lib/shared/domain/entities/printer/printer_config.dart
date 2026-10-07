// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'printer_config.g.dart';

abstract class PrinterConfig {
  final int paperSize;
  final double feedAfterPrint;
  final bool isAutoCut;
  final int copyNumber;
  final bool disconnectAfterPrint;

  PrinterConfig({
    required this.paperSize,
    required this.feedAfterPrint,
    required this.isAutoCut,
    required this.copyNumber,
    required this.disconnectAfterPrint,
  });
}

@JsonSerializable()
class PrinterBluetoothConfig extends PrinterConfig {
  final String printerAddress;
  final String printerName;

  PrinterBluetoothConfig({
    required super.paperSize,
    required super.feedAfterPrint,
    required super.isAutoCut,
    required super.copyNumber,
    required super.disconnectAfterPrint,
    required this.printerAddress,
    required this.printerName,
  });

  factory PrinterBluetoothConfig.fromJson(Map<String, dynamic> json) =>
      _$PrinterBluetoothConfigFromJson(json);

  Map<String, dynamic> toMap() => _$PrinterBluetoothConfigToJson(this);
}

// {"paperSize":58,"feedAfterPrint":0,"autoCutType":0,"copyNumber":1,"disconnectAfterPrint":true,"printerAddress":"66:32:24:A7:81:92","printerName":"MPT-II"}
