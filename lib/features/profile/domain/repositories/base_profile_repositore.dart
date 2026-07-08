import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/profile/domain/use_case/paramas/updata_profile_params.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';

abstract class BaseProfileRepository {

  Future<Either<Failure, UserEntity>> getProfile();
  Future<Either<Failure, UserEntity>> updateProfile(UpdateProfileParams params);

}