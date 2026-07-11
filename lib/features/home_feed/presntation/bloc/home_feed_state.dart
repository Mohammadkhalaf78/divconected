part of 'home_feed_bloc.dart';

class HomeFeedState extends Equatable {
  const HomeFeedState({
    this.currentPosts,
    this.getPostsMessage = '',
    this.createPostMessage = '',
    this.deletePostMessage = '',
    this.getPostsState = RequestState.inital,
    this.createPostState = RequestState.inital,
    this.deletePostState = RequestState.inital,
  });

  // data is success
  final List<PostEntities>? currentPosts;
  // data is error
  final String getPostsMessage;
  final String createPostMessage;
  final String deletePostMessage;
  // states data
  final RequestState getPostsState;
  final RequestState createPostState;
  final RequestState  deletePostState ;

  @override
  List<Object> get props => [
    currentPosts ?? [],
    getPostsMessage,
    createPostMessage,
    getPostsState,
    createPostState,
    deletePostMessage,
    deletePostState,
  ];

  HomeFeedState copyWith({
    List<PostEntities>? currentPosts,
    String? getPostsMessage,
    String? createPostMessage,
    RequestState? createPostState,
    RequestState? getPostsState,
    String? deletePostMessage,
    RequestState? deletePostState,
  }) {
    return HomeFeedState(
      currentPosts: currentPosts ?? this.currentPosts,
      getPostsMessage: getPostsMessage ?? this.getPostsMessage,
      createPostMessage: createPostMessage ?? this.createPostMessage,
      createPostState: createPostState ?? this.createPostState,
      getPostsState: getPostsState ?? this.getPostsState,
      deletePostMessage: deletePostMessage ?? this.deletePostMessage,
      deletePostState: deletePostState ?? this.deletePostState,
    );
  }
}

final class HomeFeedInitial extends HomeFeedState {}
