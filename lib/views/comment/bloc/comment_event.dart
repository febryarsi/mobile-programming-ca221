part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentGetEvent extends CommentEvent {
  final String momentId;

  const CommentGetEvent(this.momentId);
}

class CommentGetByIdEvent extends CommentEvent {
  final String commentId;

  const CommentGetByIdEvent(this.commentId);
}

class CommentAddEvent extends CommentEvent {
  final Comment newComment;

  const CommentAddEvent(this.newComment);
}

class CommentUpdateEvent extends CommentEvent {
  final Comment updatedComment;

  const CommentUpdateEvent(this.updatedComment);
}

class CommentDeleteEvent extends CommentEvent {
  final String commentId;

  const CommentDeleteEvent(this.commentId);
}