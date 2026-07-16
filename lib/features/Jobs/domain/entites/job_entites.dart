import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  const JobEntity({
     this.id,
    required this.title,
    required this.jobType,
    required this.location,
    required this.salaryRange,
    required this.description,
    required this.requirements,

    this.createdAt,
    this.companyName,
    this.companyImage,

  });

  final String title;
  final String? id;
  final JobType jobType;
  final Location location;
  final String salaryRange;
  final String description;
  final String requirements;
  final DateTime? createdAt;
  final String? companyName;
  final String? companyImage;

  @override
  List<Object?> get props => [
    title,
    jobType,
    location,
    salaryRange,
    description,
    requirements,
    createdAt,
    companyName,
    companyImage,
  ];
}
