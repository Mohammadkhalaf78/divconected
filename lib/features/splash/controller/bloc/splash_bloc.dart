import 'package:dev_connected/features/auth/domain/use_case/get_user_usecase.dart';
import 'package:dev_connected/features/splash/controller/bloc/splash_event.dart';
import 'package:dev_connected/features/splash/controller/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUserUsecase getCurrentUser;

  SplashBloc(this.getCurrentUser) : super(SplashInitial()) {
    on<InitializeAppRequested>(_initialize);
  }
  Future<void> _initialize(
    InitializeAppRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    final result = await getCurrentUser();
    result.fold(
      (failure) {
        emit(SplashFailure(failure.message));
      },
      (user) {
        emit(SplashAuthenticated(user));
      },
    );
  }
}
