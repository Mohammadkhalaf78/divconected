import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/features/Jobs/data/model/job_model.dart';
import 'package:dev_connected/features/Jobs/domain/use_case/params/create_job_params.dart';

abstract class BaseRemoteDataSource {
  Future<JobModel> createJob(CreateJobParams params);
  Future<List<JobModel>> getJobs();
}

class RemoteDataSourceImp implements BaseRemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImp(this.firestore);
  @override
  Future<JobModel> createJob(CreateJobParams params) async {
    try {
      final doc = firestore.collection('jobs').doc();

      final job = JobModel(
        id: doc.id,
        title: params.title,
        jobType: params.jobType,
        location: params.location,
        salaryRange: params.salary,
        description: params.description,
        requirements: params.requirements,
        companyName: params.companyName,
        companyImage: params.companyImage,
      );

      await doc.set(job.toJson());

      return job;
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while creating the job.',
      );
    }
  }

  @override
  Future<List<JobModel>> getJobs() async {
    try {
      final querySnapshot = await firestore.collection('jobs').get();
      return querySnapshot.docs
          .map((doc) => JobModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while fetching jobs.',
      );
    }
  }
}
