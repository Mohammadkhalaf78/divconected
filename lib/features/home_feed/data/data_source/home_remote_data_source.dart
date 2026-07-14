import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/core/network/exceptions.dart';
import 'package:dev_connected/features/home_feed/data/model/comment_model.dart';
import 'package:dev_connected/features/home_feed/data/model/post_model.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/comment_params.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/like_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<void> createPost(CreatePostParam param);
  Future<void> deletePost(String postId);
  Future<void> toggleLike(LikeParams params);
  Future<void> addComment(CommentParams params);
  Future<List<CommentModel>> getComments(String postId);
  Future<void> deleteComment(String commentId, String postId);
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

  @override
  Future<void> toggleLike(LikeParams params) async {
    try {
      // get the post document reference
      final postRef = firestore.collection('posts').doc(params.postId);

      // run a transaction to toggle the like used this for atomicity and consistency
      await firestore.runTransaction((transaction) async {
        // read new post data
        final snapshot = await transaction.get(postRef);
        // data to map and after that i have like count
        if (!snapshot.exists) {
          throw ServerException('Post not found');
        }
        final data = snapshot.data()!;

        List<String> likedBy = List<String>.from(data['likedBy'] ?? []);
        int likesCount = data['likesCount'] ?? 0;

        if (likedBy.contains(params.userId)) {
          likedBy.remove(params.userId);
          likesCount--;
        } else {
          likedBy.add(params.userId);
          likesCount++;
        }

        transaction.update(postRef, {
          'likedBy': likedBy,
          'likesCount': likesCount,
        });
      });

      // send data to firestore
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while toggling the like',
      );
    }
  }

  @override
  Future<void> addComment(CommentParams params) async {
    try {
      final postRef = firestore.collection('posts').doc(params.postId);

      final commentRef = postRef.collection('comments').doc();

      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(postRef);
        if (!snapshot.exists) {
          throw ServerException('Post not found');
        }

        await commentRef.set(
          CommentModel(
            id: commentRef.id,
            postId: params.postId,
            userId: params.userId,
            userName: params.userName,
            userImage: params.userImage ?? '',
            content: params.content,
            createdAt: DateTime.now(),
          ).toJson(),
        );

        transaction.update(postRef, {'commentsCount': FieldValue.increment(1)});
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while adding the comment',
      );
    }
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final commentsSnapshot = await firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .get();

      if (commentsSnapshot.docs.isEmpty) {
        throw const ServerException('No comments found');
      }

      return commentsSnapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data(), doc.id))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while fetching comments',
      );
    }
  }

  @override
  Future<void> deleteComment(String commentId, String postId) async {
    try {
      final postRef = firestore.collection('posts').doc(postId);
      final commentRef = postRef.collection('comments').doc(commentId);

      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(postRef);
        if (!snapshot.exists) {
          throw ServerException('Post not found');
        }

        transaction.delete(commentRef);
        transaction.update(postRef, {
          'commentsCount': FieldValue.increment(-1),
        });
      });
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'An error occurred while deleting the comment',
      );
    }
  }
}
