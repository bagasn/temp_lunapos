import 'package:pos/shared/domain/entities/printer/printer_config.dart';

class SettingPrinterEntity {
  final String id;
  final String label;

  final PrinterConfig? printerConfig;

  SettingPrinterEntity({
    required this.id,
    required this.label,
    required this.printerConfig,
  });

  SettingPrinterEntity copyWith({
    String? id,
    String? label,
    PrinterConfig? printerConfig,
  }) {
    return SettingPrinterEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      printerConfig: printerConfig ?? this.printerConfig,
    );
  }
}
