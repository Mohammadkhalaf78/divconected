import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/forgot_password_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';

class AuthRepositoryImp implements BaseAuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> forgetPassword(String email)async {
    try {
      final result = await remoteDataSource.forgotPassword(ForgotPasswordParams(email: email));
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    } 
  }

  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    try {
      final result = await remoteDataSource.register(params);
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(LoginParams params) async {
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
  
  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final result = await remoteDataSource.signInWithGoogle();
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }
  
  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final result =await remoteDataSource.logOut();
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
    
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final result = await remoteDataSource.getCurrentUser();
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }
}
