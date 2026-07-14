import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/like_params.dart';

class ToggleLikeUseCase {
  final BaseHomeRepository baseHomeRepository;

  ToggleLikeUseCase( this.baseHomeRepository);

  Future<Either<Failure, void>> call(LikeParams params) async {
    return await baseHomeRepository.toggleLike(params);
  }
}

