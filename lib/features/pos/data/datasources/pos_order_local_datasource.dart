import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/core/database/main_database.dart';
import 'package:pos/features/pos/domain/entities/pos_order_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class PosOrderLocalDataSource {
  Future<void> saveOrder(PosOrderEntity order);
}

@LazySingleton(as: PosOrderLocalDataSource)
class PosOrderLocalDataSourceImpl implements PosOrderLocalDataSource {
  final AppDatabaseManager _dbManager;
  PosOrderLocalDataSourceImpl(this._dbManager);

  static const _emptyJson = '{}';
  static const _emptyJsonArray = '[]';

  @override
  Future<void> saveOrder(PosOrderEntity order) async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');

    final now = DateTime.now();

    await db.transaction(() async {
      // 1. Insert the order header
      await db
          .into(db.tableOrder)
          .insert(
            TableOrderCompanion.insert(
              id: order.id,
              orderDate: Value(now),
              orderDateTime: Value(now),
              status: const Value('open'),
              subTotal: Value(order.subTotal),
              total: Value(order.subTotal),
              lineCount: Value(order.lineCount),
              lineTotalQty: Value(order.totalQty.toDouble()),
              createdDateTime: Value(now),
              lastUpdateDateTime: Value(now),
              // Required non-nullable JSON dump fields
              customer: _emptyJson,
              salesType: _emptyJson,
              table: _emptyJson,
              discount: _emptyJson,
              serviceChargeTax: _emptyJson,
              createdByUser: _emptyJson,
              paidByUser: _emptyJson,
              cancelledByUser: _emptyJson,
              lines: _emptyJsonArray,
              payments: _emptyJsonArray,
              taxes: _emptyJsonArray,
              coupon: _emptyJson,
              linkedOrder: _emptyJson,
              oppoCouponList: _emptyJsonArray,
              session: _emptyJson,
            ),
          );

      // 2. Insert each order line
      for (var i = 0; i < order.lines.length; i++) {
        final line = order.lines[i];
        await db
            .into(db.tableOrderLine)
            .insert(
              TableOrderLineCompanion.insert(
                id: line.id,
                orderId: order.id,
                productId: Value(line.productId),
                productVariantId: Value(line.productVariantId),
                description: Value(line.name),
                qty: Value(line.unitPrice > 0 ? line.qty.toDouble() : 0.0),
                unitPrice: Value(line.unitPrice),
                total: Value(line.lineTotal),
                totalBeforeDiscount: Value(line.lineTotal),
                notes: Value(line.notes),
                sortOrder: Value(i),
                createdDateTime: Value(now),
                cancellationDate: now,
                // Required non-nullable JSON dump fields
                rewardIds: _emptyJsonArray,
                order: _emptyJson,
                product: _emptyJson,
                productVariant: _emptyJson,
                discount: _emptyJson,
                tax: _emptyJson,
                createdByUser: _emptyJson,
                lastUpdateByUser: _emptyJson,
                cancelledByUser: _emptyJson,
                modifiers: _emptyJsonArray,
                priceTier: _emptyJson,
              ),
            );
      }
    });
  }
}
