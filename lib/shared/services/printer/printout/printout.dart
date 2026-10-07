import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

abstract class Printout {
  List<int> resetStyle(Generator generator) {
    return generator.reset();
  }
}
