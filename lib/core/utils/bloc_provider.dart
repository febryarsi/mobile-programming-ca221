import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/repositories/contracts/abs_comment_repository.dart';
import 'package:myapp/views/comment/bloc/comment_bloc.dart';

import '../../repositories/contracts/abs_moment_repository.dart';
import '../../views/moment/bloc/moment_bloc.dart';

final blocProviders = [
  BlocProvider<MomentBloc>(
    create: (context) =>
        MomentBloc(RepositoryProvider.of<AbsMomentRepository>(context)),
  ),
  BlocProvider<CommentBloc>(
    create: (context) =>
        CommentBloc(RepositoryProvider.of<AbsCommentRepository>(context)),
  ),
];
