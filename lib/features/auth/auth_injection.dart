import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:dev_connected/features/auth/data/repository/auth_repository_imp.dart';
import 'package:dev_connected/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dev_connected/features/auth/domain/use_case/get_user_usecase.dart';
import 'package:dev_connected/features/auth/domain/use_case/forget_password_usecase.dart';
import 'package:dev_connected/features/auth/domain/use_case/login_use_case.dart';
import 'package:dev_connected/features/auth/domain/use_case/logout_usecase.dart';
import 'package:dev_connected/features/auth/domain/use_case/register_use_case.dart';
import 'package:dev_connected/features/auth/domain/use_case/sign_in_with_google_usecase.dart';
import 'package:dev_connected/features/auth/presntaion/controller/bloc/auth_controller_bloc.dart';

void initAuthInjection() {
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl()));

  // Repository
  sl.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepositoryImp(
      remoteDataSource: sl(),
    ),
  );

  // Data Source
  sl.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => FirebaseRemoteDataSourceImp(
      sl(),
    
    ),
  );
}