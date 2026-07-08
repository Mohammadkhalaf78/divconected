
import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';

class SignInWithGoogleUsecase {
  SignInWithGoogleUsecase(this._authRepository);

  final BaseAuthRepository _authRepository;

  Future<Either<Failure, UserEntity>> call() {
    return _authRepository.signInWithGoogle();
  }
}