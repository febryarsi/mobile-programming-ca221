import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:myapp/views/comment/bloc/comment_bloc.dart';
import 'package:myapp/views/comment/pages/commment_entry_page.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    // Menginisialisasi BLoC dan memanggil event untuk mendapatkan komentar
    context.read<CommentBloc>().add(CommentGetEvent(widget.momentId));
  }

  Future<void> _refreshComments() async {
    // Memanggil event untuk mendapatkan komentar lagi
    context.read<CommentBloc>().add(CommentGetEvent(widget.momentId));
  }

  void _editComment(Comment comment) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CommentEntryPage(
        momentId: widget.momentId,
        comment: comment, // Mengirim komentar yang ingin diedit
      );
    })).then((_) {
      _refreshComments();
    });
  }

  void _deleteComment(String commentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Menutup dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CommentBloc>().add(CommentDeleteEvent(commentId));
              Navigator.of(context).pop();
              // Menutup dialog
              _refreshComments();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
      ),
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentGetLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentGetSuccessState) {
            final comments = state.comments;
            return SingleChildScrollView(
              child: Column(
                children: comments.map((comment) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150'), // Gambar profil
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.creator,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(comment.content),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Menambahkan tanggal di bawah konten komentar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _dateFormat.format(comment.createdAt),
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          _editComment(comment);
                                        },
                                        child: const Text('Edit'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _deleteComment(comment.id);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (state is CommentGetErrorActionState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox(); // Safe fallback
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CommentEntryPage(
              momentId: widget.momentId,
            );
          })).then((_) {
            _refreshComments();
          });
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
