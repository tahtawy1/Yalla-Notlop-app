import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/constants/app_routes.dart';
import 'package:screenshot/screenshot.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/localization/localization_cubit/localization_cubit.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/order/widgets/order_bill_card.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/features/restaurant/presentation/views/add_restaurant/widgets/primary_button.dart';

class SummaryAndActions extends StatelessWidget {
  const SummaryAndActions({
    super.key,
    required this.order,
    required this.state,
  });
  final OrderModel order;
  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final screenshotController = ScreenshotController();
    double progress = 0;
    if (order.totalAmount > 0) {
      progress = order.totalPayed / order.totalAmount;
    }
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.collected,
                    style: TextStyle(
                      color: AppColors.emptyState,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${order.totalPayed.toStringAsFixed(0)} ${context.l10n.mealPriceSuffix}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.l10n.total,
                    style: TextStyle(
                      color: AppColors.emptyState,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${order.totalAmount.toStringAsFixed(0)} ${context.l10n.mealPriceSuffix}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.iconBackground,
              color: AppColors.success,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: PrimaryButton(
                    onTap: () async {
                      final cubit = context.read<OrderCubit>();

                      final imageBytes = await screenshotController
                          .captureFromWidget(
                            Material(
                              type: MaterialType.canvas,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 2000),
                                child: SizedBox(
                                  width: MediaQuery.widthOf(context),
                                  child: OrderBillCard(
                                    cubit: cubit,
                                    members: order.members,
                                    order: order,
                                    header: Text(
                                      context.read<LocalizationCubit>().isRtl()
                                          ? 'يلا نطلب'
                                          : 'Yalla notlop',

                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    collectedLabel: context.l10n.collected,
                                    totalLabel: context.l10n.total,
                                    settledLabel: context.l10n.settled,
                                    owesLabel: context.l10n.owes,
                                    overpaidLabel: context.l10n.overpaid,
                                    paidLabel: context.l10n.paid,
                                    noOrdersLabel: context.l10n.no_orders,
                                  ),
                                ),
                              ),
                            ),
                            delay: const Duration(milliseconds: 300),
                          );
                      await cubit.shareOrder(imageBytes);
                    },
                    title: state is ShareOrderLoading
                        ? context.l10n.sharing_loading
                        : context.l10n.share_order,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  // height: 40,
                  child: PrimaryButton(
                    onTap: () {
                      context.go(AppRoutes.home);
                    },
                    title: context.l10n.back_home,
                    textColor: AppColors.primary,
                    color: AppColors.secondary.withAlpha(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
