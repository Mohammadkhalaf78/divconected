part of 'create_job_bloc.dart';

sealed class CreateJobEvent extends Equatable {
  const CreateJobEvent();

  @override
  List<Object> get props => [

  ];
}




class JobTypeChanged extends CreateJobEvent {
  final JobType jobType;

  const JobTypeChanged(this.jobType);

  @override
  List<Object> get props => [jobType];
}

class LocationChanged extends CreateJobEvent {
  final Location location;

  const LocationChanged(this.location);

  @override
  List<Object> get props => [location];
}


class CreateJobSubmitted extends CreateJobEvent {
  final String jobTitle;
  final JobType jobType;
  final Location location;
  final String salaryRange;
  final String description;
  final String requirements;
  final String companyName;
  final String companyImage;

  const CreateJobSubmitted({
    required this.jobTitle,
    required this.jobType,
    required this.location,
    required this.salaryRange,
    required this.description,
    required this.requirements,
    required this.companyName,
    required this.companyImage,
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
      ];
}
  
class GetJobRequested extends CreateJobEvent {
  const GetJobRequested();

  @override
  List<Object> get props => [];
}