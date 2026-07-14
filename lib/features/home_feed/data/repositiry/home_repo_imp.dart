import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/data/data_source/home_remote_data_source.dart';
import 'package:dev_connected/features/home_feed/domain/entites/comment_entite.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/comment_params.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/like_params.dart';

class HomeRepositoryImpl extends BaseHomeRepository {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;

  HomeRepositoryImpl({required this.baseHomeRemoteDataSource});

  @override
  Future<Either<Failure, List<PostEntities>>> getPosts() async {
    try {
      final posts = await baseHomeRemoteDataSource.getPosts();
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> createPost(CreatePostParam param) async {
    try {
      final posts = await baseHomeRemoteDataSource.createPost(param);
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String postId) async {
    try {
      final result = await baseHomeRemoteDataSource.deletePost(postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, void>> toggleLike(LikeParams params) async { 
    try {
      final result = await baseHomeRemoteDataSource.toggleLike(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addComment(CommentParams params) async {
    try {
      final result = await baseHomeRemoteDataSource.addComment(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, List<CommentEntite>>> getComments(String postId) async {
    try {
      final result = await baseHomeRemoteDataSource.getComments(postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId, String postId) async {
    try {
      final result = await baseHomeRemoteDataSource.deleteComment(commentId, postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}
