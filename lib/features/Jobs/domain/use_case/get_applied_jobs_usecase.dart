import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/domain/entites/applcation_entite.dart';
import 'package:dev_connected/features/Jobs/domain/repository/base_job_repository.dart';

class GetAppliedJobsUsecase {
  BaseJobRepository baseJobRepository;

  GetAppliedJobsUsecase(this.baseJobRepository);
  Future<Either<Failure, List<ApplicationEntity>>> call() async {
  return await baseJobRepository.getAppliedJobs();
    
  }
}
