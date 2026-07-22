import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/features/Jobs/domain/entites/enums.dart';
import 'package:dev_connected/features/Jobs/domain/entites/job_entites.dart';

class JobModel extends JobEntity {
  const JobModel({
     super.id,
    super.companyId,
    required super.title,
    required super.jobType,
    required super.location,
    required super.salaryRange,
    required super.description,
    required super.requirements,

    super.companyName,
    super.createdAt,
    super.companyImage,
  }) : super();

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      jobType: JobType.values.firstWhere(
        (e) => e.name == json['jobType'],
      ),
      location: Location.values.firstWhere(
        (e) => e.name == json['location'],
      ),
      salaryRange: json['salaryRange'] ?? '',
      description: json['description'] ?? '',
      requirements: json['requirements'] ?? '',
      companyName: json['companyName'] ?? '',
      companyImage: json['companyImage'] ?? '',
      companyId: json['companyId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'jobType': jobType.name ,
      'location': location.name,
      'salaryRange': salaryRange,
      'description': description,
      'requirements': requirements,
      'companyName': companyName,
      'companyImage': companyImage,
      'createdAt': FieldValue.serverTimestamp(),
      'companyId': companyId,
    };
  }
}
