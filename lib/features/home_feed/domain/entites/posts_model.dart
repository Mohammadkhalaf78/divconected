import 'package:equatable/equatable.dart';

abstract class PostEntities extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;

  const PostEntities({

    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    userName,
    userImage,
    title,
    content,
    imageUrl,
    createdAt,
    likesCount,
    commentsCount,
  ];
}
