// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';

class SettingPrinterEntity {
  final String id;
  final String label;
  final SettingPrinterModule? printerModule;
  final PrinterConfig? printerConfig;

  SettingPrinterEntity({
    required this.id,
    required this.label,
    required this.printerModule,
    required this.printerConfig,
  });

  SettingPrinterEntity copyWith({
    String? id,
    String? label,
    SettingPrinterModule? printerModule,
    PrinterConfig? printerConfig,
  }) {
    return SettingPrinterEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      printerModule: printerModule ?? this.printerModule,
      printerConfig: printerConfig ?? this.printerConfig,
    );
  }
}
