import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/member/data/repos/member_repo.dart';
import 'package:yalla_notlop_app/features/member/data/services/member_hive_services.dart';

class MemberRepoImp implements MemberRepo {
  final MemberHiveServices hiveService;

  MemberRepoImp({required this.hiveService});
  @override
  Future<Either<AppFailure, void>> addMember(MemberModel member) async {
    try {
      await hiveService.addMember(member);
      return right(null);
    } catch (e) {
      return left(AppFailure('حدث خطأ في إضافة العضو'));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteMember(MemberModel member) async {
    try {
      await hiveService.deleteMember(member);
      return right(null);
    } catch (e) {
      return left(AppFailure('حدث خطأ في حذف العضو'));
    }
  }

  @override
  Either<AppFailure, List<MemberModel>> getMembers() {
    try {
      final result = hiveService.getMembers();
      if (result.isEmpty) {
        return left(AppFailure('لا يوجد أعضاء'));
      }
      return right(result);
    } catch (e) {
      return left(AppFailure('حدث خطأ في جلب الأعضاء'));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateMember(MemberModel member) async {
    try {
      await hiveService.updateMember(member);
      return right(null);
    } catch (e) {
      return left(AppFailure('حدث خطأ في تحديث بيانات العضو'));
    }
  }
}
