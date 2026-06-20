import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/features/order/data/repos/order_repo/order_repo.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_history_cubit/order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderRepo orderRepo;

  OrderHistoryCubit({required this.orderRepo}) : super(OrderHistoryInitial());

  Future<void> loadHistory() async {
    emit(OrderHistoryLoading());
    final result = await orderRepo.getOrderHistory();
    result.fold(
      (failure) => emit(OrderHistoryError(message: failure.errMessage)),
      (orders) {
        if (orders.isEmpty) {
          emit(OrderHistoryEmpty());
        } else {
          emit(OrderHistoryLoaded(orders: orders));
        }
      },
    );
  }

  Future<void> deleteOrder(String id) async {
    final result = await orderRepo.deleteHistoryOrder(id);
    result.fold(
      (failure) => emit(OrderHistoryError(message: failure.errMessage)),
      (_) => loadHistory(),
    );
  }

  Future<void> clearAllHistory() async {
    final result = await orderRepo.clearHistory();
    result.fold(
      (failure) => emit(OrderHistoryError(message: failure.errMessage)),
      (_) => emit(OrderHistoryEmpty()),
    );
  }
}
