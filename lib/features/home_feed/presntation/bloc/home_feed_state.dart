part of 'home_feed_bloc.dart';

 class HomeFeedState extends Equatable {
  const HomeFeedState({
    this.currentPosts,
    this.getPostsMessage = '',
    this.getPostsState = RequestState.inital,
  });

  // data is success 
  final List<PostEntities>? currentPosts ;
  // data is error 
  final String getPostsMessage ;
  // states data 
  final RequestState getPostsState;
  
  @override
  List<Object> get props => [
    currentPosts ?? [],
    getPostsMessage,
    getPostsState,
  ];

  HomeFeedState copyWith({
    List<PostEntities>? currentPosts,
    String? getPostsMessage,
    RequestState? getPostsState,
  }) {
    return HomeFeedState(
      currentPosts: currentPosts ?? this.currentPosts,
      getPostsMessage: getPostsMessage ?? this.getPostsMessage,
      getPostsState: getPostsState ?? this.getPostsState,
    );
  }


  
}

final class HomeFeedInitial extends HomeFeedState {}
