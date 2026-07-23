import 'package:equatable/equatable.dart';

class ApplyJobParams extends Equatable {
  final String jobId;
  final String userId;
  final String companyId;
  final String companyImage;
  final String companyName;
  final String jobTitle;

  const ApplyJobParams({
    required this.jobId,
    required this.userId,
    required this.companyId,
    required this.companyImage,
    required this.companyName,
    required this.jobTitle,
  });

  @override
  List<Object?> get props => [
    jobId,
    userId,
    companyId,
    companyImage,
    companyName,
    jobTitle,
  ];
}