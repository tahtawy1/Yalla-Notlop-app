import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/core/utils/app_snack_bar.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/history/widgets/history_order_card.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_history_cubit/order_history_cubit.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_history_cubit/order_history_state.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryCubit, OrderHistoryState>(
      listener: (context, state) {
        if (state is OrderHistoryError) {
          AppSnackBar.showSnackBar(context, state.message, SnackBarType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.l10n.orderHistory,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
              builder: (context, state) {
                if (state is OrderHistoryLoaded && state.orders.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete_sweep_rounded,
                      color: AppColors.danger,
                    ),
                    tooltip: context.l10n.clearHistory,
                    onPressed: () {
                      _showClearHistoryDialog(context);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondary,
                ),
              );
            }
            if (state is OrderHistoryEmpty || state is OrderHistoryInitial) {
              return _buildEmptyState(context);
            }
            if (state is OrderHistoryLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return HistoryOrderCard(
                    order: order,
                    onDelete: () {
                      context.read<OrderHistoryCubit>().deleteOrder(order.id);
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.noOrdersYet,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppColors.emptyState,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              context.l10n.historyEmptyMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: AppColors.emptyState,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    final cubit = context.read<OrderHistoryCubit>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          context.l10n.clearHistory,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          context.l10n.deleteRestaurantWarning,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.cancel,
              style: const TextStyle(
                color: AppColors.emptyState,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.clearAllHistory();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              context.l10n.delete,
              style: const TextStyle(
                color: AppColors.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
