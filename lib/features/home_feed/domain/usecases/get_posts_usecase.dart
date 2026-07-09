import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';

class GetPostsUsecase {
  BaseHomeRepository baseHomeRepository;
  GetPostsUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<PostEntities>>> call() async {
    return await baseHomeRepository.getPosts();
  }
}