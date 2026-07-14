import 'package:equatable/equatable.dart';

 class PostEntities extends Equatable {
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
  final List<String> likedBy; 

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
    required this.likedBy,
  });

  PostEntities copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userImage,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    int? likesCount,
    int? commentsCount,
    List<String>? likedBy, 
  }) {
    return PostEntities(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      likedBy: likedBy ?? this.likedBy, 
    );
  }

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
    likedBy,
  ];
}
