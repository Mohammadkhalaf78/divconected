import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/home_feed/domain/entites/comment_entite.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/add_comment_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/delete_comment_usecase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/get_comment_useCase.dart';
import 'package:dev_connected/features/home_feed/domain/usecases/params/comment_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'commment_event.dart';
part 'commment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUsecase addCommentUseCase;
  final GetCommentUsecase getCommentUseCase;
  final DeleteCommentUsecase deleteCommentUseCase;
  CommentBloc(this.addCommentUseCase, this.getCommentUseCase, this.deleteCommentUseCase) : super(CommentInitial()) {
    on<CommentEvent>((event, emit) {});
    on<AddCommentEvent>(_addComment);
    on<FetchCommentsEvent>(_fetchComments);
    on<DeleteCommentEvent>(_deleteComment);
  }

  Future<void> _addComment(
    AddCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(addState: RequestState.loading));
    final result = await addCommentUseCase(
      CommentParams(
        content: event.commentText,
        postId: event.postId,
        userId: event.userId,
        userImage: event.userImage,
        userName: event.userName,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          addState: RequestState.error,
          addMessage: failure.message,
        ),
      ),
      (success) => emit(state.copyWith(addState: RequestState.loaded)),
    );
  }

  Future<void> _fetchComments(
    FetchCommentsEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(getState: RequestState.loading));
    final result = await getCommentUseCase(
      event.postId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          getState: RequestState.error,
          getMessage: failure.message,
        ),
      ),
      (success) => emit(
        state.copyWith(
          getState: RequestState.loaded,
          comments: success,
        ),
      ),
    );
  }

  Future<void> _deleteComment(
    DeleteCommentEvent event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await deleteCommentUseCase(
      event.commentId,
      event.postId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteState: RequestState.error,
          deleteMessage: failure.message,
        ),
      ),
      (success) => emit(state.copyWith(deleteState: RequestState.loaded)),
    );
  }
}
