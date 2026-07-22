import 'package:dartz/dartz.dart';
import 'package:dev_connected/core/network/failures.dart';
import 'package:dev_connected/features/Jobs/domain/entites/applcation_entite.dart';
import 'package:dev_connected/features/Jobs/domain/repository/base_job_repository.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/apply_job_param.dart';

class ApplyJobUseCase {
   final BaseJobRepository baseJobRepository;

   ApplyJobUseCase(this.baseJobRepository);

   Future<Either<Failure, ApplicationEntity>> call(ApplyJobParams params) async {
     return await baseJobRepository.applyForJob(params);
   }
 }