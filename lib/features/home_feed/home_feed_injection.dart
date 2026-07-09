import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/home_feed/data/data_source/home_remote_data_source.dart';
import 'package:dev_connected/features/home_feed/data/repositiry/home_repo_imp.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/get_posts_usecase.dart';
import 'package:dev_connected/features/home_feed/presntation/bloc/home_feed_bloc.dart';

void homeFeedInjection() {
  // Bloc
  sl.registerFactory(
    () => HomeFeedBloc(
      sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetPostsUsecase(sl()));

  // Repository
  sl.registerLazySingleton<BaseHomeRepository>(
    () => HomeRepositoryImpl(baseHomeRemoteDataSource: sl()
      
    ),
  );

  // Data Source
  sl.registerLazySingleton<BaseHomeRemoteDataSource>(
    () => HomeRemoteDataSource()
  );
}