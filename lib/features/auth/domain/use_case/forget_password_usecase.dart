import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';

class ForgetPasswordUsecase {
  final BaseAuthRepository authRepository;
  ForgetPasswordUsecase(this.authRepository);

  Future<Either<Failure, void>> call(String email) async {
    return await authRepository.forgetPassword(email);
  }
}