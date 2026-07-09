part of 'home_feed_bloc.dart';

 class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsRequested extends HomeFeedEvent {
  const LoadPostsRequested();
}