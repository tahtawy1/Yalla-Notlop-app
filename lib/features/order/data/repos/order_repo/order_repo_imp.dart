import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/data/repos/order_repo/order_repo.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class OrderRepoImp implements OrderRepo {
  final Box<OrderModel> historyBox;

  OrderRepoImp({required this.historyBox});

  @override
  Future<Either<AppFailure, void>> saveOrderToHistory(OrderModel order) async {
    try {
      if (historyBox.containsKey(order.id)) {
        return left(AppFailure('Order already exists in history.'));
      }
      await historyBox.put(order.id, order);
      return right(null);
    } catch (e) {
      log('Error saving order to history: $e');
      return left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<OrderModel>>> getOrderHistory() async {
    try {
      final orders = historyBox.values.toList();
      orders.sort((a, b) => b.orderTime.compareTo(a.orderTime));
      return right(orders);
    } catch (e) {
      log('Error getting order history: $e');
      return left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteHistoryOrder(String id) async {
    try {
      await historyBox.delete(id);
      return right(null);
    } catch (e) {
      log('Error deleting history order: $e');
      return left(AppFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> clearHistory() async {
    try {
      await historyBox.clear();
      return right(null);
    } catch (e) {
      log('Error clearing history: $e');
      return left(AppFailure(e.toString()));
    }
  }
}
