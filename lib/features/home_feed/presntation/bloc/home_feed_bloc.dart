import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/get_posts_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final GetPostsUsecase getPostsUsecase;
  HomeFeedBloc(this.getPostsUsecase) : super(HomeFeedInitial()) {
    on<LoadPostsRequested>(_getPosts);
  }

  Future<void> _getPosts(
    LoadPostsRequested event,
    Emitter<HomeFeedState> emit,
  ) async {
    emit(state.copyWith(getPostsState: RequestState.loading));
    final result = await getPostsUsecase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getPostsState: RequestState.error,
          getPostsMessage: failure.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          getPostsState: RequestState.loaded,
          currentPosts: r,
          getPostsMessage: '',
        ),
      ),
    );
  }
}
