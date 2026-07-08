part of 'profile_bloc.dart';

 class ProfileEvent extends Equatable {
  const ProfileEvent();


  @override
  List<Object> get props => [];
}


class GetProfileRequested extends ProfileEvent {
  

  const GetProfileRequested();

  @override
  List<Object> get props => [];
}


class UpdateProfileRequested extends ProfileEvent {
  final UpdateProfileParams params;

  const UpdateProfileRequested(this.params);

  @override
  List<Object> get props => [params];
}