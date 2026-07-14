import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntite extends Equatable {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String userImage;
  final String content;
  final DateTime createdAt;

  const CommentEntite({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.content,
    required this.createdAt,
  });

  CommentEntite copyWith({
    String? id,
    String? postId,
    String? userId,
    String? userName,
    String? userImage,
    String? content,
    FieldValue? createdAt,
  }) {
    return CommentEntite(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      content: content ?? this.content,
      createdAt: createdAt != null
          ? (createdAt as Timestamp).toDate()
          : this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    postId,
    userId,
    userName,
    userImage,
    content,
    createdAt,
  ];
}
