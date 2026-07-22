part of 'job_bloc.dart';

class JobsState extends Equatable {
  const JobsState({
    this.job,
    this.jobs,
    this.createJobMessage = '',
    this.getJobsMessage = '',
    this.applyJobMessage = '',
    this.createJobState = RequestState.inital,
    this.getJobsState = RequestState.inital,
    this.applyJobState = RequestState.inital,
    //////////////////////////////
    this.title = '',
    this.salary = '',
    this.jobtype = JobType.fullTime,
    this.experienceLevel = ExperienceLevel.entryLevel,
    this.workplaceType = Workplace.remote,
    this.location = Location.cairo,
    this.description = '',
    this.skills = const [],
    this.requirements = '',
  });
  //
  // if data is success
  final JobEntity? job;
  final List<JobEntity>? jobs;
  // if there any message error
  final String createJobMessage;
  final String getJobsMessage;
  final String applyJobMessage;
  // what state is loading or loadad or error
  final RequestState createJobState;
  final RequestState getJobsState;
  final RequestState applyJobState;
  ////////////////////////////////
  final String title;
  final JobType jobtype;
  final ExperienceLevel experienceLevel;
  final Workplace workplaceType;
  final Location location;
  final String description;
  final String salary;
  final List<String> skills;
  final String requirements;

  JobsState copyWith({
    JobEntity? job,
    List<JobEntity>? jobs,
    String? createJobMessage,
    String? getJobsMessage,
    String? applyJobMessage,
    RequestState? createJobState,
    RequestState? getJobsState,
    RequestState? applyJobState,
    
    ////////////////////////////////
    String? title,
    String? salary,
    JobType? jobtype,
    ExperienceLevel? experienceLevel,
    Workplace? workplaceType,
    Location? location,
    String? description,
    List<String>? skills,
    String? requirements,
  }) {
    return JobsState(
      job: job ?? this.job,
      jobs: jobs ?? this.jobs,
      getJobsMessage: getJobsMessage ?? this.getJobsMessage,
      getJobsState: getJobsState ?? this.getJobsState,
      createJobMessage: createJobMessage ?? this.createJobMessage,
      createJobState: createJobState ?? this.createJobState,
      applyJobMessage: applyJobMessage ?? this.applyJobMessage,
      applyJobState: applyJobState ?? this.applyJobState,
      ////////////////////////////////
      title: title ?? this.title,
      salary: salary ?? this.salary,
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
  List<Object?> get props => [
    job,
    jobs,

    createJobMessage,
    createJobState,
    getJobsMessage,
    getJobsState,
    applyJobMessage,
    applyJobState,
    ////////////////////////////////
    title,
    salary,
    jobtype,
    experienceLevel,
    workplaceType,
    location,
    description,
    skills,
    requirements,
  ];
}

final class CreateJobInitial extends JobsState {}
