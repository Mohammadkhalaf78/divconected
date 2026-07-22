import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/features/Jobs/domain/entites/applcation_entite.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';

class ApllcationModel extends ApplicationEntity {
  const ApllcationModel({
    required super.id,
    required super.jobId,
    required super.userId,
    required super.companyId,
    required super.status,
    required super.applicationAt,
  });

  factory ApllcationModel.fromJson(Map<String, dynamic> json) {
    return ApllcationModel(
      id: json['id'],
      jobId: json['jobId'],
      userId: json['userId'],
      companyId: json['companyId'],
      status: ApplicationStatus.values.firstWhere(
        (e) => e.toString() == 'ApplicationStatus.${json['status']}',
      ),
      applicationAt: DateTime.parse(json['applicationAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'userId': userId,
      'companyId': companyId,
      'status': status.name,
      'applicationAt': Timestamp.fromDate(applicationAt),
    };
  }
}
