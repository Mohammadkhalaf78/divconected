import 'package:dev_connected/features/create_job/domain/entites/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_job_event.dart';
part 'create_job_state.dart';

class CreateJobBloc extends Bloc<CreateJobEvent, CreateJobState> {
  CreateJobBloc() : super(CreateJobInitial()) {
    on<JobTitleChanged>(_onJobTitleChanged);
    on<JobTypeChanged>(_onJobTypeChanged);
    on<ExperienceLevelChanged>(_onExperienceLevelChanged);
    on<LocationChanged>(_onLocationChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<SkillAdded>(_onSkillAdded);
    on<SkillRemoved>(_onSkillRemoved);
    on<RequirementAdded>(_onRequirementAdded);
    on<RequirementRemoved>(_onRequirementRemoved);
  }
  void _onJobTitleChanged(JobTitleChanged event, Emitter<CreateJobState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onJobTypeChanged(JobTypeChanged event, Emitter<CreateJobState> emit) {
    emit(state.copyWith(jobtype: event.jobType));
  }

  void _onExperienceLevelChanged(
    ExperienceLevelChanged event,
    Emitter<CreateJobState> emit,
  ) {
    emit(state.copyWith(experienceLevel: event.level));
  }

  void _onLocationChanged(LocationChanged event, Emitter<CreateJobState> emit) {
    emit(state.copyWith(location: event.location));
  }
  void _onDescriptionChanged(DescriptionChanged event, Emitter<CreateJobState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _onSkillAdded(SkillAdded event, Emitter<CreateJobState> emit) {
    final updatedSkills = List<String>.from(state.skills)..add(event.skill);
    emit(state.copyWith(skills: updatedSkills));
  }

  void _onSkillRemoved(SkillRemoved event, Emitter<CreateJobState> emit) {
    final updatedSkills = List<String>.from(state.skills)..remove(event.skill);
    emit(state.copyWith(skills: updatedSkills));
  }

  void _onRequirementAdded(RequirementAdded event, Emitter<CreateJobState> emit) {
    final updatedRequirements = List<String>.from(state.requirements)..add(event.requirement);
    emit(state.copyWith(requirements: updatedRequirements));
  }

  void _onRequirementRemoved(RequirementRemoved event, Emitter<CreateJobState> emit) {
    final updatedRequirements = List<String>.from(state.requirements)..remove(event.requirement);
    emit(state.copyWith(requirements: updatedRequirements));
  }
}
