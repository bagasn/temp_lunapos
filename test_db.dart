import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.openInMemory();
  print('SQLite is working');
}
