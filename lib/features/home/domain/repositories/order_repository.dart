import 'package:dartz/dartz.dart';
import 'package:pos/features/home/data/models/order_model.dart';
import 'package:pos/shared/domain/entities/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderModel>> createNewOrder();
  Future<Either<Failure, OrderModel>> addItemToOrder({
    required OrderModel order,
    required String productId,
    required String productName,
    required num unitPrice,
  });
  Future<Either<Failure, OrderModel>> updateOrderLineQuantity({
    required OrderModel order,
    required String orderLineId,
    required num quantity,
  });
  Future<Either<Failure, OrderModel>> removeOrderLine({
    required OrderModel order,
    required String orderLineId,
  });
  Future<Either<Failure, void>> saveOrder(OrderModel order);
  Future<Either<Failure, void>> payOrder(OrderModel order);
  Future<Either<Failure, OrderModel?>> getActiveOrder();
}
