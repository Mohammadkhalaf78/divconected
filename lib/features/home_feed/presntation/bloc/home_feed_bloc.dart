import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/create_post_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/delete_post_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/get_posts_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/create_post_param.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final GetPostsUsecase getPostsUsecase;
  final CreatePostUseCase createPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  HomeFeedBloc(
    this.getPostsUsecase,
    this.createPostUsecase,
    this.deletePostUsecase,
  ) : super(HomeFeedInitial()) {
    on<LoadPostsRequested>(_getPosts);
    on<CreatePostRequested>(_createPost);
    on<DeletePostRequested>(_deletePost);
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

  Future<void> _createPost(
    CreatePostRequested event,
    Emitter<HomeFeedState> emit,
  ) async {
    emit(state.copyWith(createPostState: RequestState.loading));
    final result = await createPostUsecase(
      CreatePostParam(
        postContent: event.postContent,
        postImage: event.postImage,
        userImage: event.userImage,
        userName: event.userName,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          createPostState: RequestState.error,
          createPostMessage: failure.message,
        ),
      ),
      (r) => emit(state.copyWith(createPostState: RequestState.loaded)),
    );
  }

  Future<void> _deletePost(
    DeletePostRequested event,
    Emitter<HomeFeedState> emit,
  ) async {
    emit(state.copyWith(deletePostState: RequestState.loading));
    final result = await deletePostUsecase(event.postId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          deletePostState: RequestState.error,
          deletePostMessage: failure.message,
        ),
      ),
      (r) => emit(state.copyWith(deletePostState: RequestState.loaded)),
    );
  }
}
