import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/Jobs/data/data_source/remote_data_source.dart';
import 'package:dev_connected/features/Jobs/data/repository/job_repository_imp.dart';
import 'package:dev_connected/features/Jobs/domain/repository/base_job_repository.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/apply_job_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/create_job_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/get_applied_jobs_usecase.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/get_jobs_usecase.dart';
import 'package:dev_connected/features/Jobs/presntation/controller/bloc/job_bloc.dart';

void createJobInjection() {
  // Bloc
  sl.registerFactory(() => JobBloc(sl(), sl(), sl(), sl()));
  // UseCases
  sl.registerLazySingleton(() => CreateJobUseCase(sl()));
  sl.registerLazySingleton(() => GetJobsUsecase(sl()));
  sl.registerLazySingleton(() => ApplyJobUseCase(sl()));
  sl.registerLazySingleton(() => GetAppliedJobsUsecase(sl()));
  // Repository
  sl.registerLazySingleton<BaseJobRepository>(() => JobRepositoryImpl(sl()));

  // Data Source
  sl.registerLazySingleton<BaseJobRemoteDataSource>(
    () => RemoteDataSourceImp(sl(),sl()),
  );
}
