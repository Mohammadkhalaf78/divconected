import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/services/cloudinary_service.dart';
import 'package:dev_connected/features/auth/auth_injection.dart';
import 'package:dev_connected/features/home_feed/home_feed_injection.dart';
import 'package:dev_connected/features/profile/profile_injection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    // External
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<CloudinaryService>(() => CloudinaryService(sl()));

    // Features
    initAuthInjection();
    initProfileInjection();
    homeFeedInjection();
  }
}
