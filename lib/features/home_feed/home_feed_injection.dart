import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/home_feed/data/data_source/home_remote_data_source.dart';
import 'package:dev_connected/features/home_feed/data/repositiry/home_repo_imp.dart';
import 'package:dev_connected/features/home_feed/domain/repositories/home_repository.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/add_comment_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/create_post_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/delete_comment_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/delete_post_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/get_comment_useCase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/get_posts_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/toggle_like_usecase.dart';
import 'package:dev_connected/features/home_feed/presntation/controller/bloc/commment_bloc.dart';
import 'package:dev_connected/features/home_feed/presntation/controller/bloc/home_feed_bloc.dart';
import 'package:dev_connected/features/main/upload_image/cubit/upload_cubit.dart';

void homeFeedInjection() {
  // Bloc
  sl.registerFactory(() => HomeFeedBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UploadCubit(sl()));
  sl.registerFactory(() => CommentBloc(sl(), sl(), sl()));

  // UseCases
  sl.registerLazySingleton(() => GetPostsUsecase(sl()));
  sl.registerLazySingleton(() => CreatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => ToggleLikeUseCase(sl()));
  sl.registerLazySingleton(() => AddCommentUsecase(sl()));
  sl.registerLazySingleton(() => GetCommentUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCommentUsecase(sl()));
  // Repository
  sl.registerLazySingleton<BaseHomeRepository>(
    () => HomeRepositoryImpl(baseHomeRemoteDataSource: sl()),
  );

  // Data Source
  sl.registerLazySingleton<BaseHomeRemoteDataSource>(
    () => HomeRemoteDataSource(),
  );
}
