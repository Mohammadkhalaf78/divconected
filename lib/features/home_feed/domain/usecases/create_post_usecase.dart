import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';

class CreatePostUseCase {
  final BaseHomeRepository baseHomeRepository;

  CreatePostUseCase(this.baseHomeRepository);

  Future<Either<Failure, void>> call(CreatePostParam param) async {
    return await baseHomeRepository.createPost(param);
  }
}
