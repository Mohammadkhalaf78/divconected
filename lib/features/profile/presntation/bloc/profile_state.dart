part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.userProfile,
    this.profileImage,
    this.profileMessage = '',
    this.updataProfileMessage = '',
    this.profileState = RequestState.inital,
    this.updateProfileState = RequestState.inital,
  });

  // if user data is success
  final UserEntity? userProfile;
  final File? profileImage;
  // if there any message error
  final String profileMessage;
  final String updataProfileMessage;
  // what state is loading or loadad or error
  final RequestState profileState;
  final RequestState updateProfileState;

  ProfileState copyWith({
    UserEntity? userProfile,
    File? profileImage, 
    String? profileMessage,
    RequestState? profileState,
    String? updataProfileMessage,
    RequestState? updateProfileState,

  }) {
    return ProfileState(
      userProfile: userProfile ?? this.userProfile,
      profileMessage: profileMessage ?? this.profileMessage,
      profileState: profileState ?? this.profileState,
      updataProfileMessage: updataProfileMessage ?? this.updataProfileMessage,
      updateProfileState: updateProfileState ?? this.updateProfileState,
      profileImage: profileImage ?? this.profileImage
    );
  }

  @override
  List<Object> get props => [
    userProfile ?? '',
    profileMessage,
    profileState,
    updataProfileMessage,
    updateProfileState,
    profileImage ?? '',

  ];
}
