import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos/features/home/data/datasources/order_local_datasource.dart';
import 'package:pos/features/home/data/models/order_model.dart';
import 'package:pos/features/home/domain/repositories/order_repository.dart';
import 'package:pos/shared/domain/entities/failure.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDatasource _datasource;
  OrderRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, OrderModel>> createNewOrder() async {
    try {
      final now = DateTime.now();
      final order = OrderModel(
        id: const Uuid().v4(),
        status: 'active',
        createdAt: now,
        updatedAt: now,
      );
      await _datasource.saveOrder(order);
      return Right(order);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> addItemToOrder({
    required OrderModel order,
    required String productId,
    required String productName,
    required num unitPrice,
  }) async {
    try {
      final existingIndex =
          order.orderLines.indexWhere((l) => l.productId == productId);

      List<OrderLineModel> updatedLines;
      if (existingIndex >= 0) {
        // Increment quantity
        final existing = order.orderLines[existingIndex];
        final newQty = existing.quantity + 1;
        updatedLines = List.from(order.orderLines)
          ..[existingIndex] = existing.copyWith(
            quantity: newQty,
            subTotal: newQty * existing.unitPrice,
          );
      } else {
        // Add new line
        updatedLines = [
          ...order.orderLines,
          OrderLineModel(
            id: const Uuid().v4(),
            productId: productId,
            productName: productName,
            unitPrice: unitPrice,
            quantity: 1,
            subTotal: unitPrice,
          ),
        ];
      }

      final newSubTotal =
          updatedLines.fold<num>(0, (sum, l) => sum + l.subTotal);
      final updated = order.copyWith(
        orderLines: updatedLines,
        subTotal: newSubTotal,
        grandTotal: newSubTotal,
        updatedAt: DateTime.now(),
      );
      await _datasource.updateOrder(updated);
      return Right(updated);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> updateOrderLineQuantity({
    required OrderModel order,
    required String orderLineId,
    required num quantity,
  }) async {
    try {
      final idx = order.orderLines.indexWhere((l) => l.id == orderLineId);
      if (idx < 0) return Left(const CacheFailure('Order line not found'));

      List<OrderLineModel> updatedLines;
      if (quantity <= 0) {
        updatedLines = List.from(order.orderLines)..removeAt(idx);
      } else {
        final existing = order.orderLines[idx];
        updatedLines = List.from(order.orderLines)
          ..[idx] = existing.copyWith(
            quantity: quantity,
            subTotal: quantity * existing.unitPrice,
          );
      }

      final newSubTotal =
          updatedLines.fold<num>(0, (sum, l) => sum + l.subTotal);
      final updated = order.copyWith(
        orderLines: updatedLines,
        subTotal: newSubTotal,
        grandTotal: newSubTotal,
        updatedAt: DateTime.now(),
      );
      await _datasource.updateOrder(updated);
      return Right(updated);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> removeOrderLine({
    required OrderModel order,
    required String orderLineId,
  }) async =>
      updateOrderLineQuantity(
        order: order,
        orderLineId: orderLineId,
        quantity: 0,
      );

  @override
  Future<Either<Failure, void>> saveOrder(OrderModel order) async {
    try {
      final saved = order.copyWith(
        status: 'saved',
        updatedAt: DateTime.now(),
      );
      await _datasource.updateOrder(saved);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> payOrder(OrderModel order) async {
    try {
      final paid = order.copyWith(
        status: 'paid',
        updatedAt: DateTime.now(),
      );
      await _datasource.updateOrder(paid);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel?>> getActiveOrder() async {
    try {
      final order = await _datasource.getActiveOrder();
      return Right(order);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
