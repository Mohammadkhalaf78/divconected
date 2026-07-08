import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/profile/domain/repositories/base_profile_repositore.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';

class GetProfileUsecase {
  final BaseProfileRepository repository;

  GetProfileUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.getProfile();
  }
}