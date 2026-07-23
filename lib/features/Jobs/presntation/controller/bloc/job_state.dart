part of 'job_bloc.dart';

class JobState extends Equatable {
  const JobState({
    this.job,
    this.jobs,
    this.appliedJobs,
    this.createJobMessage = '',
    this.getJobsMessage = '',
    this.applyJobMessage = '',
    this.getApplyJobMessage = '',
    this.createJobState = RequestState.inital,
    this.getJobsState = RequestState.inital,
    this.applyJobState = RequestState.inital,
    this.getApplyJobState = RequestState.inital,
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
  final List<ApplicationEntity>? appliedJobs;
  // if there any message error
  final String createJobMessage;
  final String getJobsMessage;
  final String applyJobMessage;
  final String getApplyJobMessage;
  // what state is loading or loadad or error
  final RequestState createJobState;
  final RequestState getJobsState;
  final RequestState applyJobState;
  final RequestState getApplyJobState;
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

  JobState copyWith({
    JobEntity? job,
    List<JobEntity>? jobs,
    List<ApplicationEntity>? appliedJobs,
    String? createJobMessage,
    String? getJobsMessage,
    String? applyJobMessage,
    String? getApplyJobMessage,
    RequestState? createJobState,
    RequestState? getJobsState,
    RequestState? applyJobState,
    RequestState? getApplyJobState,
    
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
    return JobState(
      job: job ?? this.job,
      jobs: jobs ?? this.jobs,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      getJobsMessage: getJobsMessage ?? this.getJobsMessage,
      getJobsState: getJobsState ?? this.getJobsState,
      createJobMessage: createJobMessage ?? this.createJobMessage,
      createJobState: createJobState ?? this.createJobState,
      applyJobMessage: applyJobMessage ?? this.applyJobMessage,
      applyJobState: applyJobState ?? this.applyJobState,
      getApplyJobMessage: getApplyJobMessage ?? this.getApplyJobMessage,
      getApplyJobState: getApplyJobState ?? this.getApplyJobState,
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
    appliedJobs,

    createJobMessage,
    createJobState,
    getJobsMessage,

    getJobsState,
    applyJobMessage,
    applyJobState,
    getApplyJobMessage,
    getApplyJobState,
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

final class CreateJobInitial extends JobState {}
