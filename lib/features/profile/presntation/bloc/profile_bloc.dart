import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/profile/domain/use_case/get_profile_usecase.dart';
import 'package:dev_connected/features/profile/domain/use_case/paramas/updata_profile_params.dart';
import 'package:dev_connected/features/profile/domain/use_case/update_profile_usecase.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfileUseCase;
  final UpdateProfileUsecase updateProfileUseCase;
  ProfileBloc(this.getProfileUseCase, this.updateProfileUseCase)
    : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) {});

    on<GetProfileRequested>(_getprofile);
    on<UpdateProfileRequested>(_updateProfile);
  }

  Future<void> _getprofile(
    GetProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileState: RequestState.loading));

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          profileState: RequestState.error,
          profileMessage: failure.message,
        ),
      ),
      (r) => emit(
        state.copyWith(profileState: RequestState.loaded, userProfile: r),
      ),
    );
  }

  Future<void> _updateProfile(
    UpdateProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileState: RequestState.loading));

    final result = await updateProfileUseCase(event.params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          updateProfileState: RequestState.error,
          updataProfileMessage: failure.message,
        ),
      ),
      (r) => emit(
        state.copyWith(updateProfileState: RequestState.loaded, userProfile: r),
      ),
    );
  }
}
