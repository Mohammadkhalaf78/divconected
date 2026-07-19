part of 'auth_controller_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String phone;
  final String fullName;
  final UserRole role;
  final String imageUrl;
  const RegisterRequested({
    required this.email,
    required this.password,
    required this.phone,
    required this.fullName,
    required this.role,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [email, password, phone, fullName, role, imageUrl];
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class SignInWithGoogleRequested extends AuthEvent {
  const SignInWithGoogleRequested();

  @override
  List<Object> get props => [];
}
  
class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  @override
  List<Object> get props => [];
}


class CheckCurrentUserRequested extends AuthEvent {
  const CheckCurrentUserRequested();

  @override
  List<Object> get props => [];
}