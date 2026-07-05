import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/features/auth/data/models/user_model.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/forgot_password_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> signIn(LoginParams params);
  Future<UserModel> register(RegisterParams params);
  Future<UserModel> forgotPassword(ForgotPasswordParams params);


}

class FirebaseRemoteDataSourceImp implements BaseAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseRemoteDataSourceImp(this.firebaseAuth);
  @override
  Future<UserModel> signIn(LoginParams params) async {
    try {
      final credentials = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      if (credentials.user == null) {
        throw const ServerException('User not found');
      }

      return UserModel(
        id: credentials.user!.uid,
        email: credentials.user!.email ?? '',
        fullName: '',
        userName: '',
        isEmailVerified: credentials.user!.emailVerified,
        role: UserRole.company,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }


  }
  
  @override
  Future<UserModel> register(RegisterParams params) async {
    try {
      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      if (credentials.user == null) {
        throw const ServerException('User not found');
      }

      return UserModel(
        id: credentials.user!.uid,
        email: credentials.user!.email ?? '',
        // fullName: params.fullName,
        // userName: params.username,
        isEmailVerified: credentials.user!.emailVerified,
        role: UserRole.company, fullName: '', userName: '',
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }
    
      Future<UserModel> forgotPassword(ForgotPasswordParams params) async {
    try {
      final credentials = await firebaseAuth.sendPasswordResetEmail(
        email: params.email,
      
      );
    

      return UserModel(
        id: '',
        email:  '',
        // fullName: params.fullName,
        // userName: params.username,
        isEmailVerified: true,
        role: UserRole.company, fullName: '', userName: '',
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }
    

}
