import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/member/data/repos/member_repo.dart';

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
    log("Getting members");
    emit(GetMembersLoading());
    final result = memberRepo.getMembers();
    result.fold(
      (failure) => emit(GetMembersFailure(errMessage: failure.errMessage)),
      (members) => emit(GetMembersSuccess(members: members)),
    );
  }
}
