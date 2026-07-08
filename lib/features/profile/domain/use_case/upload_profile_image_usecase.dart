import 'dart:io' show File;

import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/profile/domain/repositories/base_profile_repositore.dart';

class UploadProfileImageUsecase {
  BaseProfileRepository repository;

  UploadProfileImageUsecase(this.repository);

  Future<Either<Failure, String>> call(File image) async {
    return await repository.updateProfileImage(image);
  }
} 