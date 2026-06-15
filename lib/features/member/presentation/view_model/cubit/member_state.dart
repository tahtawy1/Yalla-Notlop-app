part of 'member_cubit.dart';

@immutable
sealed class MemberState {}

final class MemberInitial extends MemberState {}

class AddMemberLoading extends MemberState {}

class AddMemberSuccess extends MemberState {}

class AddMemberFailure extends MemberState {
  final String errMessage;
  AddMemberFailure({required this.errMessage});
}

class DeleteMemberSuccess extends MemberState {}

class DeleteMemberFailure extends MemberState {
  final String errMessage;
  DeleteMemberFailure({required this.errMessage});
}

class UpdateMemberSuccess extends MemberState {}

class UpdateMemberFailure extends MemberState {
  final String errMessage;
  UpdateMemberFailure({required this.errMessage});
}

class GetMembersLoading extends MemberState {}

class GetMembersSuccess extends MemberState {
  final List<MemberModel> members;
  GetMembersSuccess({required this.members});
}

class GetMembersFailure extends MemberState {
  final String errMessage;
  GetMembersFailure({required this.errMessage});
}
