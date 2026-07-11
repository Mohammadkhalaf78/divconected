class CreatePostParam {
  final String postContent;
  final String userName;
  final String? userImage;
  final String? postImage;

  CreatePostParam({
    required this.postContent,
    required this.userName,
    this.postImage,
    this.userImage,
  });
}
