// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pos/shared/domain/entities/failure.dart';

part 'printer_config.g.dart';

@JsonSerializable()
class PrinterConfig {
  final String paperSize;
  final int feedAfterPrint;
  final bool isAutoCut;
  final int copyPrint;
  final bool disconnectAfterPrint;
  final String printerAddress;
  final String printerName;
  final String? vendorId;
  final String? productId;

  PrinterConfig({
    required this.paperSize,
    required this.feedAfterPrint,
    required this.isAutoCut,
    required this.copyPrint,
    required this.disconnectAfterPrint,
    required this.printerAddress,
    required this.printerName,
    this.vendorId,
    this.productId,
  });

  factory PrinterConfig.formJson(Map<String, dynamic> json) =>
      _$PrinterConfigFromJson(json);

  factory PrinterConfig.fromJsonString(String jsonString) {
    if (jsonString.isEmpty) {
      throw DatabaseFailure('Error while converting printer config.');
    }

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return _$PrinterConfigFromJson(jsonMap);
  }

  Map<String, dynamic> toMap() => _$PrinterConfigToJson(this);

  String toJsonString() {
    return jsonEncode(toMap());
  }
}
