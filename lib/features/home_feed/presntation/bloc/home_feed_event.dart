part of 'home_feed_bloc.dart';

class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsRequested extends HomeFeedEvent {
  const LoadPostsRequested();
}

class CreatePostRequested extends HomeFeedEvent {
  final String postContent;
  final String? postImage;
  final String? userImage;
  final String userName;

  const CreatePostRequested({
    required this.postContent,
    this.postImage,
    this.userImage,
    required this.userName,
  });

  @override
  List<Object> get props => [postContent, userName];
}

class DeletePostRequested extends HomeFeedEvent {
  final String postId;

  const DeletePostRequested({required this.postId});

  @override
  List<Object> get props => [postId];
}
