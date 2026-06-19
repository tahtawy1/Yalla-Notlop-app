import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/models/order_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';
import 'package:yalla_notlop_app/features/order/data/repos/share_repo/share_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.shareRepo) : super(OrderInitial());
  List<MemberModel> members = [];
  int currentIndex = 0;
  double? totalAmount;
  Map<String, Map<MealModel, int>> membersMealsOrder = {};
  int? selectedPayOption;
  late OrderModel order;
  final ShareRepo shareRepo;

  void getMembers(List<MemberModel> members) {
    this.members = members;
    log('get members');
    log(this.members.length.toString());
  }

  void nextMember() {
    if (currentIndex < members.length - 1) {
      selectedPayOption = null;
      emit(PassToNextMember());
      currentIndex++;
    } else {
      emit(FinishTheOrder(orderModel: _buildOrder()));
    }
  }

  void previousMember() {
    if (currentIndex > 0) {
      currentIndex--;
      emit(PassToPreviousMember());
    }
  }

  void addMealForMember(MemberModel member, MealModel meal) {
    membersMealsOrder[member.id] ??= {};
    if (member.meals != null) {
      member.meals!.add(meal);
      membersMealsOrder[member.id]![meal] =
          (membersMealsOrder[member.id]![meal] ?? 0) + 1;
    } else {
      member.meals = [meal];
      membersMealsOrder[member.id]![meal] = 1;
    }
    if (selectedPayOption == 0) {
      selectPayOption(member: member, index: 0);
    }
    emit(ChooseOrderForMember());
  }

  void removeMealForMember(MemberModel member, MealModel meal) {
    if (member.meals != null) {
      final index = member.meals!.indexWhere((m) => m.id == meal.id);
      if (index != -1) {
        member.meals!.removeAt(index);
        membersMealsOrder[member.id]![meal] =
            membersMealsOrder[member.id]![meal]! - 1;
        if (membersMealsOrder[member.id]![meal] == 0) {
          membersMealsOrder[member.id]!.remove(meal);
        }
      }
    }
    if (selectedPayOption == 0) {
      selectPayOption(member: member, index: 0);
    }
    emit(ChooseOrderForMember());
  }

  void confirmOrder() {
    order = _buildOrder();
  }

  void resetOrder(List<MemberModel> members) {
    for (int i = 0; i < members.length; i++) {
      members[i] = members[i].copyWith(meals: [], payedAmount: 0);
    }
    totalAmount = null;
    membersMealsOrder.clear();
    selectedPayOption = null;
    currentIndex = 0;

    members = [];
    selectedPayOption = null;
    emit(ChooseOrderForMember());
  }

  void selectPayOption({
    required MemberModel member,
    required int index,
    double? amount,
  }) {
    selectedPayOption = index;
    MemberModel updatedMember = member;
    if (index == 0) {
      log('${calculateMemberCost(member)}=================');
      updatedMember = member.copyWith(
        payedAmount: calculateMemberCost(member),
        payOption: PayOptions.payFullCost,
      );
    }
    if (index == 1 && amount != null) {
      updatedMember = member.copyWith(
        payedAmount: amount,
        payOption: PayOptions.payCustomCost,
      );
    }
    if (index == 2) {
      updatedMember = member.copyWith(
        payedAmount: 0,
        payOption: PayOptions.notPay,
      );
    }

    final memberIndex = members.indexWhere((m) => m.id == member.id);
    if (memberIndex != -1) {
      members[memberIndex] = updatedMember;
    }

    log(updatedMember.payedAmount.toString());
    emit(ChoosePayOption());
  }

  double calculateMemberCost(MemberModel member) {
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

  double calculateMemberDiff(MemberModel member) {
    return (member.payedAmount ?? 0.0) - calculateMemberCost(member);
  }

  Map<String, int> getKitchenOrder(OrderModel currentOrder) {
    Map<String, int> mealCounts = {};
    for (var member in currentOrder.members) {
      for (var meal in (member.meals ?? [])) {
        mealCounts[meal.name] = (mealCounts[meal.name] ?? 0) + 1;
      }
    }
    return mealCounts;
  }

  double _calculateTotalAmount() {
    double sum = 0;
    for (var member in members) {
      sum += calculateMemberCost(member);
    }
    return sum;
  }

  double _calculateTotalPayed() {
    double sum = 0;
    for (var member in members) {
      if (member.payOption == PayOptions.payFullCost ||
          member.payOption == PayOptions.payCustomCost) {
        sum += member.payedAmount ?? 0;
      }
    }
    return sum;
  }

  OrderModel _buildOrder() {
    return OrderModel(
      members: members,
      totalAmount: _calculateTotalAmount(),
      orderTime: DateTime.now(),
      totalPayed: _calculateTotalPayed(),
    );
  }

  Future<void> shareOrder(Uint8List imageBytes) async {
    if (isClosed) return;
    emit(ShareOrderLoading());
    try {
      await shareRepo.shareImage(
        imageBytes,
        fileName: 'yalla_notlop_bill_${DateTime.now().millisecondsSinceEpoch}',
        text: 'فاتورة الطلب من يلا نطلب 🍔',
      );
      if (isClosed) return;
      emit(ShareOrderSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(ShareOrderFailure(error: e.toString()));
    }
  }
}
