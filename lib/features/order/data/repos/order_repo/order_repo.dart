import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';

abstract class OrderRepo {
  Future<Either<AppFailure, void>> saveOrderToHistory(OrderModel order);
  Future<Either<AppFailure, List<OrderModel>>> getOrderHistory();
  Future<Either<AppFailure, void>> deleteHistoryOrder(String id);
  Future<Either<AppFailure, void>> clearHistory();
}
