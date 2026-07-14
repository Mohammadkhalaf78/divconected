part of 'commment_bloc.dart';

class CommentState extends Equatable {
  const CommentState({
    this.comments,
    this.addMessage = '',
    this.getMessage = '',
    this.deleteMessage = '',
    this.addState = RequestState.inital,
    this.getState = RequestState.inital,
    this.deleteState = RequestState.inital,
  });

  // data is success
  final List<CommentEntite>? comments;
  // data is error
  final String addMessage;
  final String getMessage;
  final String deleteMessage;
  // states data
  final RequestState addState;
  final RequestState getState;
  final RequestState deleteState;

  CommentState copyWith({
    List<CommentEntite>? comments,
    String? addMessage,
    String? getMessage,
    String? deleteMessage,
    RequestState? addState,
    RequestState? getState,
    RequestState? deleteState,
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      addMessage: addMessage ?? this.addMessage,
      getMessage: getMessage ?? this.getMessage,
      deleteMessage: deleteMessage ?? this.deleteMessage,
      addState: addState ?? this.addState,
      getState: getState ?? this.getState,
      deleteState: deleteState ?? this.deleteState,
    );
  }

  @override
  List<Object> get props => [
    comments ?? [],
    addMessage,
    getMessage,
    deleteMessage,
    addState,
    getState,
    deleteState,
  ];
}

final class CommentInitial extends CommentState {}
