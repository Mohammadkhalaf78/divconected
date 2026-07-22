import 'package:equatable/equatable.dart';

class ApplyJobParams extends Equatable {
  final String jobId;
  final String userId;
  final String companyId;

  const ApplyJobParams({
    required this.jobId,
    required this.userId,
    required this.companyId,
  });

  @override
  List<Object?> get props => [
    jobId,
    userId,
    companyId,
  ];
}