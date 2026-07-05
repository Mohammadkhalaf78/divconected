import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:dev_connected/features/auth/domain/entites/user.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/forgot_password_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';

class AuthRepositoryImp implements BaseAuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthUser>> forgetPassword(String email)async {
    try {
      final result = await remoteDataSource.forgotPassword(ForgotPasswordParams(email: email));
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    } 
  }

  @override
  Future<Either<Failure, AuthUser>> register(RegisterParams params) async {
    try {
      final result = await remoteDataSource.register(params);
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signIn(LoginParams params) async {
    try {
      final result = await remoteDataSource.signIn(params);
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail() {
    throw UnimplementedError();
  }
}
