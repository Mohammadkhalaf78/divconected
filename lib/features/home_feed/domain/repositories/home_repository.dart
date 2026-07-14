import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/entites/comment_entite.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/comment_params.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/like_params.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<PostEntities>>> getPosts();
  Future<Either<Failure, void>> createPost(CreatePostParam param);
  Future<Either<Failure, void>> deletePost(String postId);
  Future<Either<Failure, void>> toggleLike(LikeParams params);
  Future<Either<Failure, void>> addComment(CommentParams params);
  Future<Either<Failure, List<CommentEntite>>> getComments(String postId);
  Future<Either<Failure, void>> deleteComment(String commentId, String postId);
}
