import 'package:dev_connected/sherad/entites/user_entity.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashNavigateToLogin extends SplashState {}

class SplashAuthenticated extends SplashState{

final UserEntity user;

SplashAuthenticated(this.user);

}final class SplashFailure extends SplashState {
  final String message;

  SplashFailure(this.message);
}