import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';

class SignoutUsecase {
  final BaseAuthRepository authRepository;
  SignoutUsecase(this.authRepository);

  Future<void> call() async {
    return await authRepository.signOut();
  }
}