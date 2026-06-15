import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';

class MemberHiveServices {
  final Box<MemberModel> membersBox;
  MemberHiveServices({required this.membersBox});
  Future<void> addMember(MemberModel member) async {
    try {
      await membersBox.put(member.id, member);
      log('member added ${getMembers().length}');
    } catch (e) {
      log('errror in adding member ${e.toString()}');
    }
  }

  Future<void> deleteMember(MemberModel member) async {
    await membersBox.delete(member.id);
  }

  Future<void> updateMember(MemberModel member) async {
    await membersBox.put(member.id, member);
  }

  List<MemberModel> getMembers() {
    return membersBox.values.toList();
  }
}
