import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:pos/shared/services/printer/printout/printout.dart';

class TestprintPrintout extends Printout {
  Future<List<int>> buildPrintout(Generator generator) async {
    List<int> printContent = [];

    printContent += generator.emptyLines(1);
    printContent += generator.text(
      'Tes Print',
      styles: const PosStyles(align: PosAlign.center),
    );

    return printContent;
  }

  Future<List<int>> getPrintout() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    List<int> printContent = [];

    printContent += resetStyle(generator);

    printContent += await buildPrintout(generator);

    printContent += generator.reset();
    printContent += generator.feed(3);

    return printContent;
  }
}
