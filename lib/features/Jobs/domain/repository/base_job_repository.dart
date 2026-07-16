import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart';

abstract class BaseJobRepository {
  Future<Either<Failure, JobEntity>> createJob(CreateJobParams params);
  Future<Either<Failure, List<JobEntity>>> getJobs();


}