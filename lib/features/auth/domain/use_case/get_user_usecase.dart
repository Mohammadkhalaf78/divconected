import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';

class GetCurrentUserUsecase {
  BaseAuthRepository repository;

  GetCurrentUserUsecase( this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getCurrentUser();
  }
}