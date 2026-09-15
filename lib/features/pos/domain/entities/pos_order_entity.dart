import 'package:equatable/equatable.dart';
import 'package:pos/features/pos/domain/entities/pos_order_line_entity.dart';

/// Entity yang merepresentasikan order yang sedang aktif (cart in-memory).
class PosOrderEntity extends Equatable {
  final String id; // UUID, dibuat saat order pertama kali dibuat
  final List<PosOrderLineEntity> lines;

  const PosOrderEntity({required this.id, required this.lines});

  double get subTotal =>
      lines.fold(0.0, (sum, line) => sum + line.lineTotal);

  int get totalQty => lines.fold(0, (sum, line) => sum + line.qty);

  int get lineCount => lines.length;

  PosOrderEntity copyWith({String? id, List<PosOrderLineEntity>? lines}) {
    return PosOrderEntity(
      id: id ?? this.id,
      lines: lines ?? this.lines,
    );
  }

  @override
  List<Object?> get props => [id, lines];
}
