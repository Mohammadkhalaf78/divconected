import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:dev_connected/features/profile/domain/repositories/base_profile_repositore.dart';
import 'package:dev_connected/features/profile/domain/use_case/paramas/updata_profile_params.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';

class ProfileRepositoryImp implements BaseProfileRepository {
  BaseProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final result =await remoteDataSource.getUserProfile();
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UpdateProfileParams params) async {
    try {
      final result = await remoteDataSource.updateUserProfile(params);
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfileImage(File image)async {
    try {
      final result =await remoteDataSource.updateProfileImage(image);
      return Right(result);
    } on ServerException catch (failure) {
      return left(ServerFailure(failure.message));
    }
  }
}
