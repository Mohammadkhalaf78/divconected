part of 'create_job_bloc.dart';

class CreateJobState extends Equatable {
  const CreateJobState({
    // add default values for first screen is has values
    this.title = '',
    this.jobtype = JobType.fullTime,
    this.experienceLevel = ExperienceLevel.entryLevel,
    this.workplaceType = Workplace.remote,
    this.location = Location.cairo,
    this.description = '',
    this.skills = const [],
    this.requirements = const [],
  });
  final String title;
  final JobType jobtype;
  final ExperienceLevel experienceLevel;
  final Workplace workplaceType;
  final Location location;
  final String description;
  final List<String> skills;
  final List<String> requirements;

  CreateJobState copyWith({
    String? title,
    JobType? jobtype,
    ExperienceLevel? experienceLevel,
    Workplace? workplaceType,
    Location? location,
    String? description,
    List<String>? skills,
    List<String>? requirements,
  }) {
    return CreateJobState(
      title: title ?? this.title,
      jobtype: jobtype ?? this.jobtype,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      workplaceType: workplaceType ?? this.workplaceType,
      location: location ?? this.location,
      description: description ?? this.description,
      skills: skills ?? this.skills,
      requirements: requirements ?? this.requirements,
    );
  }

  @override
  List<Object> get props => [
    title,
    jobtype,
    experienceLevel,
    workplaceType,
    location,
    description,
    skills,
    requirements,
  ];
}

final class CreateJobInitial extends CreateJobState {}
