import 'package:meta/meta.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';

@immutable
sealed class OrderHistoryState {}

final class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<OrderModel> orders;
  OrderHistoryLoaded({required this.orders});
}

class OrderHistoryEmpty extends OrderHistoryState {}

class OrderHistoryError extends OrderHistoryState {
  final String message;
  OrderHistoryError({required this.message});
}
