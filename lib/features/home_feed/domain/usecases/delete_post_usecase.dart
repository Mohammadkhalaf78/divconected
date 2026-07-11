import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';

class DeletePostUsecase {
  BaseHomeRepository baseHomeRepository;
  DeletePostUsecase(this.baseHomeRepository);
  Future<Either<Failure, void>> call(String postId) async {
    return await baseHomeRepository.deletePost(postId);
  }
}
