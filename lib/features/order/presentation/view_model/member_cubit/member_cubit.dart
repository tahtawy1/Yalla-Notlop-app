import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_notlop_app/core/extension/context_extension.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/repos/member_repo/member_repo.dart';

part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  final MemberRepo memberRepo;
  MemberCubit(this.memberRepo) : super(MemberInitial());

  Future<void> addMember(MemberModel member) async {
    emit(AddMemberLoading());
    final result = await memberRepo.addMember(member);
    result.fold(
      (failure) => emit(AddMemberFailure(errMessage: failure.errMessage)),
      (_) {
        emit(AddMemberSuccess());
        getMembers();
      },
    );
  }

  Future<void> deleteMember(MemberModel member) async {
    final result = await memberRepo.deleteMember(member);
    result.fold(
      (failure) => emit(DeleteMemberFailure(errMessage: failure.errMessage)),
      (_) {
        emit(DeleteMemberSuccess());
        getMembers();
      },
    );
  }

  Future<void> updateMember(String name, MemberModel member) async {
    final newMember = member.copyWith(name: name);
    final result = await memberRepo.updateMember(newMember);
    result.fold(
      (failure) => emit(UpdateMemberFailure(errMessage: failure.errMessage)),
      (_) {
        emit(UpdateMemberSuccess());
        getMembers();
      },
    );
  }

  void getMembers() {
    emit(GetMembersLoading());
    final result = memberRepo.getMembers();
    result.fold(
      (failure) => emit(GetMembersFailure(errMessage: failure.errMessage)),
      (members) => emit(GetMembersSuccess(members: members)),
    );
  }

  void checkButtonState(BuildContext context) {
    if (memberRepo.isReadyToStart()) {
      final List<MemberModel> members = memberRepo.getMembers().fold(
        (failure) => [],
        (members) => members,
      );
      emit(ReadyToStart(members: members));
    } else {
      emit(NotEnoughMembers(message: context.l10n.noEnoughMembersWarning));
    }
  }
}
