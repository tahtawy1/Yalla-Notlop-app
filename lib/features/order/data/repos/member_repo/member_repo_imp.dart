import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';
import 'package:yalla_notlop_app/features/order/data/repos/member_repo/member_repo.dart';
import 'package:yalla_notlop_app/features/order/data/services/member_hive_services.dart';
import 'package:yalla_notlop_app/generated/l10n.dart';

class MemberRepoImp implements MemberRepo {
  final MemberHiveServices hiveService;

  MemberRepoImp({required this.hiveService});
  @override
  Future<Either<AppFailure, void>> addMember(MemberModel member) async {
    try {
      await hiveService.addMember(member);
      return right(null);
    } catch (e) {
      return left(AppFailure(S.current.memberAddError));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteMember(MemberModel member) async {
    try {
      await hiveService.deleteMember(member);
      return right(null);
    } catch (e) {
      return left(AppFailure(S.current.memberDeleteError));
    }
  }

  @override
  Either<AppFailure, List<MemberModel>> getMembers() {
    try {
      final result = hiveService.getMembers();
      if (result.isEmpty) {
        return left(AppFailure(S.current.memberGetEmpty));
      }
      return right(result);
    } catch (e) {
      return left(AppFailure(S.current.memberGetError));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateMember(MemberModel member) async {
    try {
      await hiveService.updateMember(member);
      return right(null);
    } catch (e) {
      return left(AppFailure(S.current.memberUpdateError));
    }
  }

  @override
  bool isReadyToStart() {
    final members = hiveService.getMembers();
    return members.length >= 2;
  }
}
