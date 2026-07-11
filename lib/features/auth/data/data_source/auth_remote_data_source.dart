import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/sherad/models/user_model.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/forgot_password_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/login_params.dart';
import 'package:dev_connected/features/auth/domain/use_case/params/register_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> signIn(LoginParams params);
  Future<UserModel> register(RegisterParams params);
  Future<void> forgotPassword(ForgotPasswordParams params);
  Future<UserModel> signInWithGoogle();
  Future<void> logOut();
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
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(credentials.user!.uid)
          .get();

      if (!doc.exists) {
        throw const ServerException('User data not found');
      }

      return UserModel.fromMap(doc.data()!);
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

      final uId = credentials.user!.uid;

      final userModel = UserModel(
        id: uId,
        fullName: params.fullName,
        email: params.email,
        userName: '',
        isEmailVerified: credentials.user!.emailVerified,
        role: UserRole.developer,
        phone: params.phone,
        createdAt: params.createdAt,
        bio: '',
        imageUrl: '',
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<void> forgotPassword(ForgotPasswordParams params) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: params.email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '1091087640765-nsqfulg8u18qeuu7vb67gs139ektcnt8.apps.googleusercontent.com',
      );

      final googleUser = await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user == null) {
        throw const ServerException('User not found');
      }

      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        final userModel = UserModel(
          id: user.uid,
          email: user.email ?? '',
          fullName: user.displayName ?? '',
          userName: '',
          isEmailVerified: user.emailVerified,
          role: UserRole.company,
          phone: '',
          createdAt: DateTime.now().toIso8601String(),
          bio: '',
          imageUrl: user.photoURL ?? '',
        );

        await userDoc.set(userModel.toMap());
      } else {
        await userDoc.set({
          'imageUrl': user.photoURL ?? '',
          'email': user.email ?? '',
        }, SetOptions(merge: true));
      }

      return UserModel.fromMap((await userDoc.get()).data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }
}
