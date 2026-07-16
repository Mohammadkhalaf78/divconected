import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/repository/base_job_repository.dart';

class GetJobsUsecase {
  BaseJobRepository baseJobRepository;
  GetJobsUsecase( this.baseJobRepository);

  Future<Either<Failure, List<JobEntity>>> call() async {
    return await baseJobRepository.getJobs();
  }
}