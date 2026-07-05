import 'package:dev_connected/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:dev_connected/features/auth/data/repository/auth_repository_imp.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dev_connected/features/auth/domain/use_case/forget_password_usecase.dart';
import 'package:dev_connected/features/auth/domain/use_case/login_use_case.dart';
import 'package:dev_connected/features/auth/domain/use_case/register_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    //use case
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(()=> RegisterUseCase(sl()));
    sl.registerLazySingleton(()=> ForgetPasswordUsecase(sl()));
    //repositories
    sl.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepositoryImp(remoteDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => FirebaseRemoteDataSourceImp(sl()),
    );

    // External
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  }
}
