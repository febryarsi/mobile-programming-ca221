import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:myapp/models/comment.dart';
import 'package:myapp/views/comment/bloc/comment_bloc.dart';
import 'package:nanoid2/nanoid2.dart';
import '../../../core/resources/colors.dart';

class CommentEntryPage extends StatefulWidget {
  const CommentEntryPage({super.key, required this.momentId, this.comment});

  final String momentId;
  final Comment? comment; // Tambahkan parameter untuk komentar

  @override
  State<CommentEntryPage> createState() => _CommentEntryPageState();
}

class _CommentEntryPageState extends State<CommentEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataComment = {};

  @override
  void initState() {
    super.initState();
    // Jika ada komentar yang diterima, isi form dengan data komentar
    if (widget.comment != null) {
      _dataComment['creator'] = widget.comment!.creator;
      _dataComment['caption'] = widget.comment!.content;
    }
  }

  void _saveComment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Comment newComment = Comment(
        id: widget.comment?.id ??
            nanoid(), // Gunakan ID jika mengedit, jika tidak buat ID baru
        creator: _dataComment['creator'],
        content: _dataComment['caption'],
        createdAt: DateTime.now(),
        momentId: widget.momentId,
      );

      if (widget.comment != null) {
        // Jika mengedit komentar yang ada
        context.read<CommentBloc>().add(CommentUpdateEvent(newComment));
      } else {
        // Jika menambahkan komentar baru
        context.read<CommentBloc>().add(CommentAddEvent(newComment));
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(largeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Creator'),
                TextFormField(
                  initialValue: _dataComment['creator'] ?? '',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Moment creator',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moment creator';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['creator'] = newValue;
                    }
                  },
                ),
                const Text('Comment'),
                TextFormField(
                  initialValue: _dataComment['caption'] ?? '',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Comment description',
                    prefixIcon: const Icon(Icons.note),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter comment caption';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['caption'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: largeSize),
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: _saveComment,
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(height: mediumSize),
                SizedBox(
                  height: 50.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
