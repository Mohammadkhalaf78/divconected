import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/entites/comment_entite.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommentUsecase {
  BaseHomeRepository baseHomeRepository;

  GetCommentUsecase(this.baseHomeRepository);

  Future<Either<Failure, List<CommentEntite>>> call(
    String postId,
  ) async {
    return await baseHomeRepository.getComments(postId);
  }
}
