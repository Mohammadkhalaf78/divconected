class CommentParams {
  final String postId;
  final String userId;
  final String content;
  final String userName;  
  final String? userImage;

  CommentParams({
    required this.postId,
    required this.userId,
    required this.content,
    required this.userName,
    this.userImage,
  });
}
