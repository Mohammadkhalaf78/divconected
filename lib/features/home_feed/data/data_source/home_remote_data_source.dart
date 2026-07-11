import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/features/home_feed/data/model/post_model.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<void> createPost(CreatePostParam param);
  Future<void> deletePost(String postId);

}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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

  @override
  Future<void> createPost(CreatePostParam param) async {
    try {
      final uid = firebaseAuth.currentUser?.uid;
      final newPost = {
        'userId': uid,
        'content': param.postContent,
        'imageUrl': param.postImage,
        'createdAt': FieldValue.serverTimestamp(),
        'commentsCount': 0,
        'likesCount': 0,
        'userImage': param.userImage,
        'userName': param.userName,
      };

      await firestore.collection('posts').add(newPost);


      // Fetch the updated list of posts after creating a new post
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while creating the post',
      );
    }
  }
  
  @override
  Future<void> deletePost(String postId) async {
    try {
      await firestore.collection('posts').doc(postId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while deleting the post',
      );
    }
  }
}
