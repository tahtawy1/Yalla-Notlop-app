import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/core/theme/app_colors.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';

class HistoryOrderCard extends StatelessWidget {
  const HistoryOrderCard({
    super.key,
    required this.order,
    required this.onDelete,
  });

  final OrderModel order;
  final VoidCallback onDelete;

  double _calculateMemberCost(MemberModel member) {
    final meals = member.meals ?? [];
    double sum = 0;
    for (var meal in meals) {
      try {
        sum += double.parse(meal.price.toString());
      } catch (e) {
        // ignore
      }
    }
    return sum;
  }

  double _calculateMemberDiff(MemberModel member) {
    return (member.payedAmount ?? 0.0) - _calculateMemberCost(member);
  }

  Map<MealModel, int> _getMemberMeals(MemberModel member) {
    Map<MealModel, int> mealsMap = {};
    for (var meal in member.meals ?? []) {
      var key = mealsMap.keys.firstWhere(
        (m) => m.id == meal.id,
        orElse: () => meal,
      );
      if (mealsMap.containsKey(key)) {
        mealsMap[key] = mealsMap[key]! + 1;
      } else {
        mealsMap[key] = 1;
      }
    }
    return mealsMap;
  }

  Widget _buildMemberItem(BuildContext context, MemberModel member) {
    double memberCost = _calculateMemberCost(member);
    double diff = _calculateMemberDiff(member);
    final meals = _getMemberMeals(member);
    String statusText;
    Color statusColor;
    Widget? badge;
    bool isPayer = false;
    bool owes = false;

    if (diff == 0 && memberCost >= 0) {
      statusText = context.l10n.settled;
      statusColor = Colors.green.shade700;
      badge = const Icon(Icons.check_circle, color: Colors.green, size: 16);
    } else if (diff < 0) {
      owes = true;
      statusText =
          '${context.l10n.owes} ${diff.abs().toStringAsFixed(0)} ${context.l10n.mealPriceSuffix}';
      statusColor = AppColors.dangerColor;
      badge = const Icon(Icons.error, color: AppColors.dangerColor, size: 16);
    } else {
      statusText =
          '${context.l10n.overpaid} ${diff.toStringAsFixed(0)} ${context.l10n.mealPriceSuffix}';
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
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isPayer
                  ? Colors.green.shade200
                  : owes
                  ? AppColors.backgroundColor
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(16),
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
            if (meals.isNotEmpty) ...[
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
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.splashTitleColor,
                        ),
                      ),
                      Text(
                        '${double.parse(e.key.price) * e.value} ${context.l10n.mealPriceSuffix}',
                        style: const TextStyle(
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
                context.l10n.no_orders,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.splashTitleColor,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${context.l10n.paid}: ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.splashTitleColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      TextSpan(
                        text:
                            '${member.payedAmount == member.payedAmount?.toInt() ? member.payedAmount?.toInt() : member.payedAmount?.toStringAsFixed(2)} ${context.l10n.mealPriceSuffix}',
                        style: const TextStyle(
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

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.restaurantIconBg,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.history_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dateFormat.format(order.orderTime),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.dangerColor,
                    size: 20,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          ExpansionTileTheme(
            data: ExpansionTileThemeData(
              shape: Border.all(color: Colors.transparent),
            ),
            child: ExpansionTile(
              splashColor: Colors.transparent,
              tilePadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 4,
                bottom: 4,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.people_outline_rounded,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${order.members.length} ${context.l10n.members}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              order.totalAmount.toStringAsFixed(0),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                color: AppColors.splashTitleColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                context.l10n.mealPriceSuffix,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          context.l10n.collected,
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          order.totalPayed.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              children: [
                ...order.members.map(
                  (member) => _buildMemberItem(context, member),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
