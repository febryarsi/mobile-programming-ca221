import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/models/comment.dart';
import 'package:myapp/repositories/contracts/abs_comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AbsCommentRepository _commentRepository;
  List<Comment> _comments = [];

  CommentBloc(this._commentRepository) : super(CommentInitial()) {
    on<CommentGetEvent>(commentGetEvent);
    on<CommentGetByIdEvent>(commentGetByIdEvent);
    on<CommentAddEvent>(commentAddEvent);
    on<CommentUpdateEvent>(commentUpdateEvent);
    on<CommentDeleteEvent>(commentDeleteEvent);
  }

  FutureOr<void> commentGetEvent(
      CommentGetEvent event, Emitter<CommentState> emit) async {
    emit(CommentGetLoadingState());
    try {
      _comments =
          await _commentRepository.getCommentsByMomentId(event.momentId);
      emit(CommentGetSuccessState(_comments));
    } catch (e) {
      emit(CommentGetErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentAddEvent(
      CommentAddEvent event, Emitter<CommentState> emit) async {
    emit(CommentAddingState());
    try {
      await _commentRepository.addComment(event.newComment);
      _comments.add(event.newComment);
      emit(CommentAddedSuccessActionState(event.newComment));
    } catch (e) {
      emit(CommentAddedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentUpdateEvent(
      CommentUpdateEvent event, Emitter<CommentState> emit) async {
    emit(CommentUpdatingState());
    try {
      await _commentRepository.updateComment(event.updatedComment);
      _comments[_comments.indexWhere((c) => c.id == event.updatedComment.id)] =
          event.updatedComment;
      emit(CommentUpdatedSuccessActionState(event.updatedComment));
    } catch (e) {
      emit(CommentUpdatedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentDeleteEvent(
      CommentDeleteEvent event, Emitter<CommentState> emit) async {
    emit(CommentDeletingState());
    try {
      await _commentRepository.deleteComment(event.commentId);
      _comments.removeWhere((c) => c.id == event.commentId);
      emit(CommentDeletedSuccessActionState());
    } catch (e) {
      emit(CommentDeletedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentGetByIdEvent(
      CommentGetByIdEvent event, Emitter<CommentState> emit) async {
    emit(CommentGetByIdLoadingState());
    try {
      final comment = await _commentRepository.getCommentById(event.commentId);
      print("WKWKWK $comment");
      if (comment != null) {
        emit(CommentGetByIdSuccessState(comment));
      } else {
        emit(const CommentGetByIdErrorActionState('Comment not found.'));
      }
    } catch (e) {
      emit(CommentGetByIdErrorActionState(e.toString()));
    }
  }
}
