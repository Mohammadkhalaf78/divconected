import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';

class VerifyEmailUsecase {
  final BaseAuthRepository authRepository;
  VerifyEmailUsecase(this.authRepository);

  Future<void> call() async {
    return await authRepository.verifyEmail();
  }
}