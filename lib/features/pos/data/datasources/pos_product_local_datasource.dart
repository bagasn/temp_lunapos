import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/core/database/app_database_manager.dart';
import 'package:pos/features/pos/domain/entities/product_entity.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class PosProductLocalDataSource {
  Future<List<PosProductEntity>> getProducts({
    required int limit,
    required int offset,
    String? searchQuery,
  });
}

@LazySingleton(as: PosProductLocalDataSource)
class PosProductLocalDataSourceImpl implements PosProductLocalDataSource {
  final AppDatabaseManager _dbManager;

  PosProductLocalDataSourceImpl(this._dbManager);

  @override
  Future<List<PosProductEntity>> getProducts({
    required int limit,
    required int offset,
    String? searchQuery,
  }) async {
    final db = await _dbManager.mainDb;
    if (db == null) throw const CacheFailure('Database not initialized');

    final query =
        db.select(db.tableProduct).join([
            leftOuterJoin(
              db.tableProductVariant,
              db.tableProductVariant.id.equalsExp(
                    db.tableProduct.masterVariantId,
                  ) &
                  db.tableProductVariant.deleted.equals(false),
            ),
          ])
          ..where(db.tableProduct.deleted.equals(false))
          ..limit(limit, offset: offset);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where(db.tableProduct.name.like('%$searchQuery%'));
    }

    final rows = await query.get();

    return rows.map((row) {
      final product = row.readTable(db.tableProduct);
      final variant = row.readTableOrNull(db.tableProductVariant);

      return PosProductEntity(
        id: product.id,
        name: product.name,
        sku: product.sku,
        pictureUrl: product.pictureUrl,
        hasVariants: product.hasVariants ?? false,
        isOutOfStock: product.isOutOfStock,
        isFavorite: product.isFavorite,
        modifierCount: product.modifierCount ?? 0,
        unitPrice: variant?.unitPrice ?? 0.0,
        masterVariantId: product.masterVariantId,
      );
    }).toList();
  }
}
