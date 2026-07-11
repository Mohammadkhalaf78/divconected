import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<PostEntities>>> getPosts();
  Future<Either<Failure, void>> createPost (CreatePostParam param);
  Future<Either<Failure, void>> deletePost(String postId);
}
