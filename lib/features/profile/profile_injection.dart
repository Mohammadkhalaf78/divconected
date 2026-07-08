import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:dev_connected/features/profile/data/repoitories/profile_repository_imp.dart';
import 'package:dev_connected/features/profile/domain/repositories/base_profile_repositore.dart';
import 'package:dev_connected/features/profile/domain/use_case/get_profile_usecase.dart';
import 'package:dev_connected/features/profile/domain/use_case/update_profile_usecase.dart';
import 'package:dev_connected/features/profile/presntation/bloc/profile_bloc.dart';

void initProfileInjection() {
  // Bloc
  sl.registerFactory(() => ProfileBloc(sl(),sl()));

  // UseCase
  sl.registerLazySingleton(() => GetProfileUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUsecase(sl()));

  // Repository
  sl.registerLazySingleton<BaseProfileRepository>(
    () => ProfileRepositoryImp(remoteDataSource: sl()),
  );

  // Data Source
  sl.registerLazySingleton<BaseProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImp(sl()),
  );
}
