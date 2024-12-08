part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

abstract class CommentActionState extends CommentState {
  const CommentActionState();
}

abstract class CommentLoadingState extends CommentState {}

final class CommentGetLoadingState extends CommentLoadingState {}

final class CommentGetSuccessState extends CommentState {
  final List<Comment> comments;

  const CommentGetSuccessState(this.comments);
}

class CommentGetErrorActionState extends CommentActionState {
  final String message;

  const CommentGetErrorActionState(this.message);
}

final class CommentGetByIdLoadingState extends CommentLoadingState {}

final class CommentGetByIdSuccessState extends CommentState {
  final Comment comment;

  const CommentGetByIdSuccessState(this.comment);
}

class CommentGetByIdErrorActionState extends CommentActionState {
  final String message;

  const CommentGetByIdErrorActionState(this.message);
}

final class CommentAddingState extends CommentLoadingState {}

final class CommentAddedSuccessActionState extends CommentActionState {
  final Comment comment;

  const CommentAddedSuccessActionState(this.comment);
}

final class CommentAddedErrorActionState extends CommentActionState {
  final String message;

  const CommentAddedErrorActionState(this.message);
}

final class CommentUpdatingState extends CommentLoadingState {}

final class CommentUpdatedSuccessActionState extends CommentActionState {
  final Comment comment;

  const CommentUpdatedSuccessActionState(this.comment);
}

final class CommentUpdatedErrorActionState extends CommentActionState {
  final String message;

  const CommentUpdatedErrorActionState(this.message);
}

final class CommentDeletingState extends CommentLoadingState {}

final class CommentDeletedSuccessActionState extends CommentActionState {}

final class CommentDeletedErrorActionState extends CommentActionState {
  final String message;

  const CommentDeletedErrorActionState(this.message);
}