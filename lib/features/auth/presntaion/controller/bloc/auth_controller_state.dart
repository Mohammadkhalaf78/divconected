part of 'auth_controller_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.currentUser,
    this.loginMessage = '',
    this.forgotPasswordMessage = '',
    this.registerMessage = '',
    this.logInState = RequestState.inital,
    this.registerState = RequestState.inital,
    this.forgotPasswordState = RequestState.inital,
  });

  AuthState copyWith({
    AuthUser? currentUser,
    String? loginMessage,
    String? forgotPasswordMessage,
    String? registerMessage,
    RequestState? logInState,
    RequestState? registerState,
    RequestState? forgotPasswordState,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      loginMessage: loginMessage ?? this.loginMessage,
      forgotPasswordMessage:
          forgotPasswordMessage ?? this.forgotPasswordMessage,
      logInState: logInState ?? this.logInState,
      registerState: registerState ?? this.registerState,
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      registerMessage: registerMessage ?? this.registerMessage,
    );
  }

  // if data is success
  final AuthUser? currentUser;
  // if there any message error
  final String loginMessage;
  final String forgotPasswordMessage;
  final String registerMessage;
  // what state is loading or loadad or error
  final RequestState logInState;
  final RequestState registerState;
  final RequestState forgotPasswordState;

  @override
  List<Object?> get props => [
    currentUser,
    loginMessage,
    logInState,
    registerState,
    forgotPasswordState,
    forgotPasswordMessage,
    registerMessage,
  ];
}

final class AuthControllerInitial extends AuthState {}

@override
final class PasswordVisibilityChanged extends AuthState {
  final bool isPasswordVisible;

  PasswordVisibilityChanged(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}
