import 'package:drift/drift.dart';
import 'package:pos/shared/utilities/date_formatter.dart';

class OffsetDateTimeConverter extends TypeConverter<DateTime?, String?> {
  const OffsetDateTimeConverter();

  @override
  DateTime? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return DateFormatter.fromSql(fromDb);
  }

  @override
  String? toSql(DateTime? value) {
    if (value == null) return null;
    return DateFormatter.toSql(value);
  }
}
