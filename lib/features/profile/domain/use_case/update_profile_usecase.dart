import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/profile/domain/repositories/base_profile_repositore.dart';
import 'package:dev_connected/features/profile/domain/use_case/paramas/updata_profile_params.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';

class UpdateProfileUsecase {
  UpdateProfileUsecase(this.repository);

  final BaseProfileRepository repository;

  Future<Either<Failure, UserEntity>> call(UpdateProfileParams user) async {
    return await repository.updateProfile(user);
  }
}