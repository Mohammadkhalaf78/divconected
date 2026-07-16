import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';
import 'package:dev_connected/features/Jobs/domain/repository/base_job_repository.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart'
    show CreateJobParams;

class CreateJobUseCase {
  final BaseJobRepository repository;

  CreateJobUseCase(this.repository);

  Future<Either<Failure, JobEntity>> call(CreateJobParams params) async {
    return await repository.createJob(params);
  }
}
