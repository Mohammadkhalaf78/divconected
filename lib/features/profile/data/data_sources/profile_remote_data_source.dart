import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/features/profile/domain/use_case/paramas/updata_profile_params.dart';
import 'package:dev_connected/sherad/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseProfileRemoteDataSource {
  Future<UserModel> getUserProfile();
  Future<UserModel> updateUserProfile(UpdateProfileParams params);
}

class ProfileRemoteDataSourceImp implements BaseProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final firebaseAuth = FirebaseAuth.instance;

  ProfileRemoteDataSourceImp(this.firestore);

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final uid =  firebaseAuth.currentUser!.uid;
      final userDoc = await firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        throw const ServerException('User not found');
      }
      return UserModel.fromMap(userDoc.data()!);
    }on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }
  
  @override
  Future<UserModel> updateUserProfile(UpdateProfileParams params) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      final userDocRef = firestore.collection('users').doc(uid);
      await userDocRef.update(params.toMap());
      final updatedUserDoc = await userDocRef.get();
      return UserModel.fromMap(updatedUserDoc.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }
}