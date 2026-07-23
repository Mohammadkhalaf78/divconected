part of 'job_bloc.dart';

sealed class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class JobTypeChanged extends JobEvent {
  final JobType jobType;

  const JobTypeChanged(this.jobType);

  @override
  List<Object> get props => [jobType];
}

class LocationChanged extends JobEvent {
  final Location location;

  const LocationChanged(this.location);

  @override
  List<Object> get props => [location];
}

class CreateJobSubmitted extends JobEvent {
  final String jobTitle;
  final JobType jobType;
  final Location location;
  final String salaryRange;
  final String description;
  final String requirements;
  final String companyName;
  final String companyImage;
  final String companyId;

  const CreateJobSubmitted({
    required this.jobTitle,
    required this.jobType,
    required this.location,
    required this.salaryRange,
    required this.description,
    required this.requirements,
    required this.companyName,
    required this.companyImage,
    required this.companyId,
  });

  @override
  List<Object> get props => [
    jobTitle,
    jobType,
    location,
    salaryRange,
    description,
    requirements,
    companyName,
    companyImage,
    companyId,
  ];
}

class GetJobRequested extends JobEvent {
  const GetJobRequested();

  @override
  List<Object> get props => [];
}

class ApplyJobRequested extends JobEvent {
  final String jobId;
  final String userId;
  final String companyId;
  final String companyImage;
  final String companyName;
  final String jobTitle;

  const ApplyJobRequested({
    required this.jobId,
    required this.userId,
    required this.companyId,
    required this.companyImage,
    required this.companyName,
    required this.jobTitle,
  });

  @override
  List<Object> get props => [
    jobId,
    userId,
    companyId,
    companyImage,
    companyName,
    jobTitle,
  ];
}

class GetAppliedJobsRequested extends JobEvent {
  const GetAppliedJobsRequested();

  @override
  List<Object> get props => [];
}
