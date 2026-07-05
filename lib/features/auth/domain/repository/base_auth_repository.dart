import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/domain/entites/user.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, AuthUser>> signIn(LoginParams params);
  Future<Either<Failure, AuthUser>> register(RegisterParams params);
  Future<void> signOut();
  Future<Either<Failure, AuthUser>> forgetPassword(String email);
  Future<void> verifyEmail();
}
