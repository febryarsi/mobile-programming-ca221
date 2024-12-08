import 'dart:developer';
import 'package:myapp/models/comment.dart';
import '../../core/helpers/database_helper.dart';
import '../contracts/abs_comment_repository.dart';

class DbCommentRepository extends AbsCommentRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Future<void> addComment(Comment comment) async {
    try {
      final db = await databaseHelper.database;
      await db.insert(
        DatabaseHelper.tableComments,
        comment.toMap(),
      );
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:addComment');
    }
  }

  @override
  Future<void> updateComment(Comment comment) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        DatabaseHelper.tableComments,
        comment.toMap(),
        where: 'id = ?',
        whereArgs: [comment.id],
      );
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:updateComment');
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DatabaseHelper.tableComments,
        where: 'id = ?',
        whereArgs: [commentId],
      );
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:deleteComment');
    }
  }

  @override
  Future<List<Comment>> getCommentsByMomentId(String momentId) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(
        DatabaseHelper.tableComments,
        where: 'momentId = ?',
        whereArgs: [momentId],
      );
      return result.map((e) => Comment.fromMap(e)).toList();
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:getCommentsByMomentId');
      return [];
    }
  }

  @override
  Future<Comment?> getCommentById(String commentId) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(
        DatabaseHelper.tableComments,
        where: 'id = ?',
        whereArgs: [commentId],
      );
      if (result.isEmpty) {
        return null;
      } else {
        return Comment.fromMap(result.first);
      }
    } catch (e) {
      log(e.toString(), name: 'db_comment_repository:getCommentById');
      return null;
    }
  }
}