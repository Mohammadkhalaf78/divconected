import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/comment_params.dart';

class AddCommentUsecase {
  BaseHomeRepository repository;
  AddCommentUsecase(this.repository);

  Future<Either<Failure, void>> call(CommentParams params) async {
    return await repository.addComment(params);
  }
}
