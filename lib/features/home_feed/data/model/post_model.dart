import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';

class PostModel extends PostEntities {
  const PostModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.userImage,
    required super.title,
    required super.content,
    super.imageUrl,
    required super.createdAt,
    required super.likesCount,
    required super.commentsCount,
    required super.likedBy,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String id) {
    return PostModel(
      id: id,
      userId: json['userId']?? '',
      userName: json['userName'] ?? '',
      userImage: json['userImage'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      likedBy: List<String>.from(json['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'likedBy': likedBy,
    };
  }
}
