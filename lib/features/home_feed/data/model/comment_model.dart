import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/features/home_feed/domain/entites/comment_entite.dart';

class CommentModel extends CommentEntite {
  const CommentModel({
    required super.id,
    required super.postId,
    required super.userId,
    required super.userName,
    required super.userImage,
    required super.content,
    required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json, String id) {
    return CommentModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String,
      content: json['content'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'content': content,
      'createdAt': createdAt,
    };
  }
}
