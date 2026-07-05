import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/domain/entites/user.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';

class RegisterUseCase {
  final BaseAuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<Either<Failure, AuthUser>> call(RegisterParams params) async {
    return await authRepository.register(params);
  }
}
