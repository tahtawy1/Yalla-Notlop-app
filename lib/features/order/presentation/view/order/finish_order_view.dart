import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/presentation/view/order/widgets/summary_and_actions.dart';
import 'package:yalla_notlop_app/features/order/presentation/view_model/order_cubit/order_cubit.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';
import 'package:yalla_notlop_app/shared/widgets/app_logo.dart';
import 'package:screenshot/screenshot.dart';

class FinishOrderView extends StatelessWidget {
  final OrderModel order;
  final ScreenshotController screenshotController = ScreenshotController();
  FinishOrderView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Map<String, int> mealCounts = context.read<OrderCubit>().getKitchenOrder(
      order,
    );

    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const AppLogo(),
            centerTitle: true,
            leading: CloseButton(onPressed: () => context.go('/home')),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          color: const Color(0xFF59DF5D).withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 46,
                          color: Colors.green.shade900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        S.of(context).order_confirmed,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppColors.splashTitleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        S.of(context).kitchen_preparing,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.splashSubtitleColor,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).kitchen_order,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.splashTitleColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              S.of(context).grouped,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: mealCounts.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: AppColors.restaurantIconBg,
                                    child: const Icon(
                                      Icons.fastfood,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.splashTitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${entry.value}x',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        S.of(context).per_person_details,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.splashTitleColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...order.members.map(
                        (member) => _buildMemberItem(context, member),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SummaryAndActions(order: order, state: state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMemberItem(BuildContext context, MemberModel member) {
    double memberCost = context.read<OrderCubit>().calculateMemberCost(member);
    double diff = context.read<OrderCubit>().calculateMemberDiff(member);
    final meals = context.read<OrderCubit>().membersMealsOrder[member.id];
    String statusText;
    Color statusColor;
    Widget? badge;
    bool isPayer = false;
    bool owes = false;

    if (diff == 0 && memberCost >= 0) {
      statusText = S.of(context).settled;
      statusColor = Colors.green.shade700;
      badge = const Icon(Icons.check_circle, color: Colors.green, size: 16);
    } else if (diff < 0) {
      owes = true;
      statusText =
          '${S.of(context).owes} ${diff.abs().toStringAsFixed(0)} ${S.of(context).meal_price_suffix}';
      statusColor = AppColors.dangerColor;
      badge = const Icon(Icons.error, color: AppColors.dangerColor, size: 16);
    } else {
      statusText =
          '${S.of(context).overpaid} ${diff.toStringAsFixed(0)} ${S.of(context).meal_price_suffix}';
      statusColor = Colors.green.shade700;
      isPayer = true;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ExpansionTileTheme(
        data: ExpansionTileThemeData(
          collapsedBackgroundColor: isPayer
              ? Colors.green.shade50
              : owes
              ? AppColors.dangerBackground
              : Colors.white,
          backgroundColor: isPayer
              ? Colors.green.shade50
              : owes
              ? AppColors.dangerBackground
              : Colors.white,
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide(
              color: isPayer
                  ? Colors.green.shade200
                  : owes
                  ? Colors.red.shade200
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isPayer
                  ? Colors.green.shade200
                  : owes
                  ? AppColors.backgroundColor
                  : Colors.white,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: ExpansionTile(
          splashColor: Colors.transparent,
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),

          title: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.restaurantIconBg,
                    child: Text(
                      member.name.isNotEmpty ? member.name[0] : '?',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (badge != null)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: badge,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.splashTitleColor,
                      ),
                    ),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            if (meals != null && meals.isNotEmpty) ...[
              ...meals.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${e.value} × ${e.key.name}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.splashTitleColor,
                        ),
                      ),
                      Text(
                        '${double.parse(e.key.price) * e.value} ${S.of(context).mealPriceSuffix}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Text(
                S.of(context).no_orders,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.splashTitleColor,
                ),
              ),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${S.of(context).paid}: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.splashTitleColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      TextSpan(
                        text:
                            '${member.payedAmount == member.payedAmount?.toInt() ? member.payedAmount?.toInt() : member.payedAmount?.toStringAsFixed(2)} ${S.of(context).mealPriceSuffix}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
