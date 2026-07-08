import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';

class LogoutUsecase {
  LogoutUsecase(this._authRepository);

  final BaseAuthRepository _authRepository;

  Future<Either<Failure, void>> call() {
    return _authRepository.logOut();
  }
}