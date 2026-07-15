import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/auth/domain/use_case/logout_usecase.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:dev_connected/features/auth/domain/use_case/forget_password_usecase.dart';
import 'package:dev_connected/features/auth/domain/use_case/login_use_case.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/register_use_case.dart';
import 'package:dev_connected/features/auth/domain/use_case/sign_in_with_google_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_controller_event.dart';
part 'auth_controller_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }

  final RegisterUseCase registerUseCase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc(
    this.loginUseCase,
    this.registerUseCase,
    this.forgetPasswordUsecase,
    this.signInWithGoogleUsecase, this.logoutUsecase,
  ) : super(const AuthState()) {
    on<LoginRequested>(_login);
    on<RegisterRequested>(_register);
    on<ForgotPasswordRequested>(_forgotPassword);
    on<SignInWithGoogleRequested>(_signInWithGoogle);
    on<LogoutRequested>(_logout);
  }

  Future<void> _login(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(logInState: RequestState.loading));

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          logInState: RequestState.error,
          loginMessage: failure.message,
        ),
      ),
      (r) =>
          emit(state.copyWith(logInState: RequestState.loaded, currentUser: r)),
    );
  }

  Future<void> _register(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(registerState: RequestState.loading));

    final result = await registerUseCase(
      RegisterParams(
        email: event.email,
        password: event.password,
        phone: event.phone,
        fullName: event.fullName,
        createdAt: DateTime.now().toIso8601String(),
        role: event.role,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          registerState: RequestState.error,
          registerMessage: failure.message,
        ),
      ),
      (r) => emit(
        state.copyWith(registerState: RequestState.loaded, currentUser: r),
      ),
    );
  }

  Future<void> _forgotPassword(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(forgotPasswordState: RequestState.loading));

    final result = await forgetPasswordUsecase(event.email);

    result.fold(
      (failure) => emit(
        state.copyWith(
          forgotPasswordState: RequestState.error,
          forgotPasswordMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(forgotPasswordState: RequestState.loaded)),
    );
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(signInWithGoogleState: RequestState.loading));

    final result = await signInWithGoogleUsecase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          signInWithGoogleState: RequestState.error,
          signinWithGoogleMessage: failure.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          signInWithGoogleState: RequestState.loaded,
          currentUser: r,
        ),
      ),
    );
  }
 
  Future<void> _logout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(logoutState: RequestState.loading));

    final result = await logoutUsecase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          logoutState: RequestState.error,
          logoutMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          logoutState: RequestState.loaded,
          currentUser: null,
        ),
      ),
    );
  }

}
