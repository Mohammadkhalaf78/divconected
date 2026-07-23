import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/domain/entites/applcation_entite.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/apply_job_param.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart';

abstract class BaseJobRepository {
  Future<Either<Failure, JobEntity>> createJob(CreateJobParams params);
  Future<Either<Failure, List<JobEntity>>> getJobs();
  Future<Either<Failure, ApplicationEntity>> applyForJob(ApplyJobParams params);
  Future<Either<Failure, List<ApplicationEntity>>> getAppliedJobs();

}