part of 'commment_bloc.dart';

class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class AddCommentEvent extends CommentEvent {
  final String postId;
  final String commentText;
  final String userId;
  final String userImage;
  final String userName;

  const AddCommentEvent({
    required this.postId,
    required this.commentText,
    required this.userId,
    required this.userImage,
    required this.userName,
  });

  @override
  List<Object> get props => [postId, commentText, userId, userImage, userName];
}


class FetchCommentsEvent extends CommentEvent {
  final String postId;

  const FetchCommentsEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;
  final String postId;  

  const DeleteCommentEvent({required this.commentId, required this.postId});

  @override
  List<Object> get props => [commentId, postId];
}