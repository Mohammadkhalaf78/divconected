import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/auth/domain/entites/user.dart';
import 'package:dev_connected/features/auth/domain/use_case/forget_password_usecase.dart';
import 'package:dev_connected/features/auth/domain/use_case/login_use_case.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/register_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_controller_event.dart';
part 'auth_controller_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }

  final RegisterUseCase registerUseCase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  AuthBloc(this.loginUseCase, this.registerUseCase, this.forgetPasswordUsecase)
    : super(AuthControllerInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<ForgotPasswordEvent>(_forgotPassword);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
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

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(registerState: RequestState.loading));

    final result = await registerUseCase(
      RegisterParams(email: event.email, password: event.password),
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
    ForgotPasswordEvent event,
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
      (_) => emit(
        state.copyWith(
          forgotPasswordState: RequestState.loaded,
        ),
      ),
    );
  }
}
