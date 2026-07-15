part of 'create_job_bloc.dart';

sealed class CreateJobEvent extends Equatable {
  const CreateJobEvent();

  @override
  List<Object> get props => [

  ];
}




class JobTitleChanged extends CreateJobEvent {

  final String title;

  const JobTitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class JobTypeChanged extends CreateJobEvent {
  final JobType jobType;

  const JobTypeChanged(this.jobType);

  @override
  List<Object> get props => [jobType];
}

class ExperienceLevelChanged extends CreateJobEvent {
  final ExperienceLevel level ;

  const ExperienceLevelChanged(this.level);

  @override
  List<Object> get props => [level];
}

class PublishJobRequested extends CreateJobEvent {}

class LocationChanged extends CreateJobEvent {
  final Location location;

  const LocationChanged(this.location);

  @override
  List<Object> get props => [location];
}

class DescriptionChanged extends CreateJobEvent {
  final String description;

  const DescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class SkillAdded extends CreateJobEvent {
  final String skill;

  const SkillAdded(this.skill);

  @override
  List<Object> get props => [skill];
}

class SkillRemoved extends CreateJobEvent {
  final String skill;

  const SkillRemoved(this.skill);

  @override
  List<Object> get props => [skill];
}

class RequirementAdded extends CreateJobEvent {
  final String requirement;

  const RequirementAdded(this.requirement);

  @override
  List<Object> get props => [requirement];
}

class RequirementRemoved extends CreateJobEvent {
  final String requirement;

  const RequirementRemoved(this.requirement);

  @override
  List<Object> get props => [requirement];
}