import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/features/Jobs/domain/entites/applcation_entite.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';

class ApllcationModel extends ApplicationEntity {
  const ApllcationModel({
    required super.companyImage,
    required super.companyName,
    required super.jobTitle,
    required super.id,
    required super.jobId,
    required super.userId,
    required super.companyId,
    required super.status,
    required super.applicationAt,
  });

  factory ApllcationModel.fromJson(Map<String, dynamic> json) {
    return ApllcationModel(
      companyImage: json['companyImage'],
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      id: json['id'],
      jobId: json['jobId'],
      userId: json['userId'],
      companyId: json['companyId'],
      status: ApplicationStatus.values.firstWhere(
        (e) => e.toString() == 'ApplicationStatus.${json['status']}',
      ),
      applicationAt: (json['applicationAt'] as Timestamp).toDate(),
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
      'companyImage': companyImage,
      'companyName': companyName,
      'jobTitle': jobTitle,
    };
  }
}
