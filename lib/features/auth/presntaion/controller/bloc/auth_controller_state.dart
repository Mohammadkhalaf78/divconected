part of 'auth_controller_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.currentUser,
    this.loginMessage = '',
    this.forgotPasswordMessage = '',
    this.signinWithGoogleMessage = '',
    this.registerMessage = '',
    this.logInState = RequestState.inital,
    this.registerState = RequestState.inital,
    this.forgotPasswordState = RequestState.inital,
    this.signInWithGoogleState = RequestState.inital,
  });

  AuthState copyWith({
    UserEntity? currentUser,
    String? loginMessage,
    String? forgotPasswordMessage,
    String? signinWithGoogleMessage,
    String? registerMessage,
    RequestState? logInState,
    RequestState? registerState,
    RequestState? forgotPasswordState,
    RequestState? signInWithGoogleState,
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
      signinWithGoogleMessage: signinWithGoogleMessage ?? this.signinWithGoogleMessage,
      signInWithGoogleState: signInWithGoogleState ?? this.signInWithGoogleState,
    );
  }

  // if data is success
  final UserEntity? currentUser;
  // if there any message error
  final String loginMessage;
  final String forgotPasswordMessage;
  final String registerMessage;
  final String signinWithGoogleMessage;
  // what state is loading or loadad or error
  final RequestState logInState;
  final RequestState registerState;
  final RequestState forgotPasswordState;
  final RequestState signInWithGoogleState;

  @override
  List<Object?> get props => [
    currentUser,
    loginMessage,
    logInState,
    registerState,
    forgotPasswordState,
    forgotPasswordMessage,
    registerMessage,
    signinWithGoogleMessage,
    signInWithGoogleState,
  ];
}


@override
final class PasswordVisibilityChanged extends AuthState {
  final bool isPasswordVisible;

  PasswordVisibilityChanged(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}
