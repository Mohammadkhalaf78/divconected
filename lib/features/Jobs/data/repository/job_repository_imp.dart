import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/data/data_source/remote_data_source.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/repository/base_job_repository.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart';

class JobRepositoryImpl implements BaseJobRepository {
  final BaseRemoteDataSource remoteDataSource;
  JobRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, JobEntity>> createJob(CreateJobParams params) async {
    // Implementation for creating a job
    try {
      final result = await remoteDataSource.createJob(params);
      return Right(result);
    }on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getJobs() async {
    try {
      final result = await remoteDataSource.getJobs();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
