import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/features/home_feed/data/model/post_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final postsSnapshot = await firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

      if (postsSnapshot.docs.isEmpty) {
        throw const ServerException('No posts found');
      }
      return postsSnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data(), doc.id))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    }
  }
}
