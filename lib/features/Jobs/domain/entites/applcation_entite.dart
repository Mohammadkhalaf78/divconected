import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:equatable/equatable.dart';

abstract class ApplicationEntity extends Equatable {
  final String id;
  final String jobId;
  final String userId;
  final String companyId;
  final String companyImage;
  final String companyName;
  final String jobTitle;
  final ApplicationStatus status;
  final DateTime applicationAt;

  const ApplicationEntity({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.companyId,
    required this.companyImage,
    required this.companyName,
    required this.jobTitle,
    required this.status,
    required this.applicationAt,
  });

  @override
  List<Object?> get props => [
    id,
    jobId,
    userId,
    companyId,
    companyImage,
    companyName,
    jobTitle,
    status,
    applicationAt,
  ];
}
