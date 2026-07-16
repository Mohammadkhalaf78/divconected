part of 'auth_controller_bloc.dart';


// this class is used to manage the state of the auth controller bloc
class AuthState extends Equatable {
  const AuthState({
    this.currentUser,
    this.loginMessage = '',
    this.forgotPasswordMessage = '',
    this.signinWithGoogleMessage = '',
    this.registerMessage = '',
    this.logoutMessage = '',
    this.checkCurrentUserMessage = '',
    this.logInState = RequestState.inital,
    this.registerState = RequestState.inital,
    this.forgotPasswordState = RequestState.inital,
    this.signInWithGoogleState = RequestState.inital,
    this.logoutState = RequestState.inital,
    this.checkCurrentUserState = RequestState.inital,

  });

  AuthState copyWith({
    UserEntity? currentUser,
    String? loginMessage,
    String? forgotPasswordMessage,
    String? signinWithGoogleMessage,
    String? registerMessage,
    String? logoutMessage,
    String? checkCurrentUserMessage,

    RequestState? logInState,
    RequestState? registerState,
    RequestState? forgotPasswordState,
    RequestState? signInWithGoogleState,
    RequestState? logoutState,
    RequestState? checkCurrentUserState,

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
      logoutMessage: logoutMessage ?? this.logoutMessage,
      logoutState: logoutState ?? this.logoutState,
      checkCurrentUserState: checkCurrentUserState ?? this.checkCurrentUserState,
      checkCurrentUserMessage: checkCurrentUserMessage ?? this.checkCurrentUserMessage,
    );
  }

  // if data is success
  final UserEntity? currentUser;
  // if there any message error
  final String loginMessage;
  final String forgotPasswordMessage;
  final String registerMessage;
  final String signinWithGoogleMessage;
  final String logoutMessage ;
  final String checkCurrentUserMessage ;
  // what state is loading or loadad or error
  final RequestState logInState;
  final RequestState registerState;
  final RequestState forgotPasswordState;
  final RequestState signInWithGoogleState;
  final RequestState logoutState ;
  final RequestState checkCurrentUserState ;

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
    logoutMessage,
    logoutState,
    checkCurrentUserState,
    checkCurrentUserMessage,
  ];
}


@override
final class PasswordVisibilityChanged extends AuthState {
  final bool isPasswordVisible;

const  PasswordVisibilityChanged(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}
