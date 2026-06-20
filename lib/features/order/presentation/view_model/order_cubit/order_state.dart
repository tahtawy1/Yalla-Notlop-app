part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class PassToNextMember extends OrderState {}

class PassToPreviousMember extends OrderState {}

class FinishTheOrder extends OrderState {
  final OrderModel orderModel;
  FinishTheOrder({required this.orderModel});
}

class ShareOrderLoading extends OrderState {}

class ShareOrderSuccess extends OrderState {}

class ShareOrderFailure extends OrderState {
  final String error;
  ShareOrderFailure({required this.error});
}

class ChooseOrderForMember extends OrderState {}

class ChoosePayOption extends OrderState {}
