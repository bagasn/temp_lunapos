import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:pos/shared/domain/entities/printer/printer_config.dart';
import 'package:pos/shared/domain/entities/printer/printer_setup.dart';
import 'package:pos/shared/services/printer/printout/printout.dart';

class TestprintPrintout extends Printout {
  Future<List<int>> buildPrintout(
    Generator generator,
    PrinterConfig printerConfig,
  ) async {
    List<int> printContent = [];

    printContent += generator.emptyLines(1);
    printContent += generator.text(
      'Tes Print',
      styles: const PosStyles(align: PosAlign.center),
    );

    return printContent;
  }

  Future<List<int>> getPrintout({
    required String printerAreaLabel,
    required SettingPrinterModule printerModule,
    required PrinterConfig printerConfig,
  }) async {
    final profile = await CapabilityProfile.load();
    final mPaperSize = printerConfig.paperSize == '58'
        ? PaperSize.mm58
        : PaperSize.mm80;
    final generator = Generator(mPaperSize, profile);

    List<int> printContent = [];

    printContent += generator.reset();
    printContent += await buildPrintout(generator, printerConfig);
    printContent += generator.text(
      printerAreaLabel,
      styles: PosStyles(align: PosAlign.center),
    );
    printContent += generator.reset();

    printContent += generator.feed(printerConfig.feedAfterPrint);
    if (printerConfig.isAutoCut) {
      printContent += generator.cut();
    }

    return printContent;
  }
}
