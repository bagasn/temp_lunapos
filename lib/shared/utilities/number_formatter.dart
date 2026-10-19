import 'package:intl/intl.dart';

class NumberFormatter {
  NumberFormatter._();

  static const String currencyLocale = 'de_DE';

  static NumberFormat _formatter({
    String locale = currencyLocale,
    int decimalDigits = 0,
  }) {
    return NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits,
    );
  }

  static String currency(
    double value, {
    String prefix = 'Rp ',
    String suffix = '',
  }) {
    try {
      final formattedValue = _formatter(decimalDigits: 2).format(value);
      return '$prefix$formattedValue$suffix';
    } catch (e) {
      return '-';
    }
  }

  static String decimal(double value, {int decimalDigits = 0}) {
    try {
      return _formatter(decimalDigits: decimalDigits).format(value);
    } catch (e) {
      return '-';
    }
  }

  static String percent(double value) {
    try {
      final formattedValue = _formatter().format(value);
      return '$formattedValue%';
    } catch (e) {
      return '-';
    }
  }

  static String format(num amount) => _formatter().format(amount);

  static String formatCompact(num amount) {
    if (amount >= 1000000) {
      return 'Rp${(amount / 1000000).toStringAsFixed(1)}jt';
    } else if (amount >= 1000) {
      return 'Rp${(amount / 1000).toStringAsFixed(0)}k';
    }
    return format(amount);
  }
}
