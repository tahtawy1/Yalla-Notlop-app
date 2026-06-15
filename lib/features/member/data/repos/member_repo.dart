import 'package:dartz/dartz.dart';
import 'package:yalla_notlop_app/core/error/app_failure.dart';
import 'package:yalla_notlop_app/features/member/data/models/member_model.dart';

abstract class MemberRepo {
  Future<Either<AppFailure, void>> addMember(MemberModel member);
  Future<Either<AppFailure, void>> deleteMember(MemberModel member);
  Future<Either<AppFailure, void>> updateMember(MemberModel member);
  Either<AppFailure, List<MemberModel>> getMembers();
}
