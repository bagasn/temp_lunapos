import 'package:intl/intl.dart';
import 'package:pos/shared/utilities/log_util.dart';

final class DateFormatter {
  const DateFormatter._();

  static String sqlDatePattern = "yyyy-MM-dd HH:mm:ss Z";

  static String? toSql(DateTime date) {
    try {
      final formatter = DateFormat(sqlDatePattern, 'en_US');
      return formatter.format(date);
    } catch (e, stack) {
      LogUtil.e(e.toString(), stackTrace: stack);
      return null;
    }
  }

  static DateTime? fromSql(String value) {
    try {
      final formatter = DateFormat(sqlDatePattern, 'en_US');
      return formatter.parse(value);
    } catch (e, stack) {
      LogUtil.e(e.toString(), stackTrace: stack);
      return null;
    }
  }
}
