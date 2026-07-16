import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';

class CreateJobParams {
  final String title;
  final JobType jobType;
  final String description;
  final Location location;
  final String salary;
  final String requirements;
  final String companyName;
  final String companyImage;

  CreateJobParams({
    required this.title,
    required this.description,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.requirements,
    required this.companyName,
    required this.companyImage,
  });
}