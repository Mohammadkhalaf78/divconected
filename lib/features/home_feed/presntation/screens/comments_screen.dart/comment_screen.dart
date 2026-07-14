import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/home_feed/presntation/controller/bloc/commment_bloc.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, required this.user, required this.postId});

  final UserEntity user;
  final String postId;
  final TextEditingController comt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc(sl(), sl(), sl())
            ..add(FetchCommentsEvent(postId: postId)),
      child: BlocConsumer<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state.addState == RequestState.error) {
            AppTopSnackBar.error(context, message: state.addMessage);
          } else if (state.addState == RequestState.loaded) {
            comt.clear();
            context.read<CommentBloc>().add(FetchCommentsEvent(postId: postId));
          } else if (state.deleteState == RequestState.error) {
            AppTopSnackBar.error(context, message: state.deleteMessage);
          } else if (state.deleteState == RequestState.loaded) {
            context.read<CommentBloc>().add(FetchCommentsEvent(postId: postId));
          }
        },
        builder: (context, state) {
          final comments = state.comments ?? [];
          return Scaffold(
            appBar: AppBar(title: const Text("Comments")),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: comments.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 80,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "No comments yet.",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: comments.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 14),
                            itemBuilder: (context, index) {
                              final c = comments[index];
                              return Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 8,
                                      color: Color(0x12000000),
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage(
                                        c.userImage,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  c.userName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                timeago.format(
                                                  c.createdAt,
                                                  locale: 'en_short',
                                                ),
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      context
                                                          .read<CommentBloc>()
                                                          .add(
                                                            DeleteCommentEvent(
                                                              commentId: c.id,
                                                              postId: postId,
                                                            ),
                                                          );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            c.content,
                                            style: const TextStyle(height: 1.4),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.favorite_border,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text("Like"),
                                              SizedBox(width: 24),
                                              Icon(
                                                Icons.reply_outlined,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text("Reply"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Color(0x14000000),
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.imageUrl ?? ''),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: comt,
                              decoration: InputDecoration(
                                hintText: "Write a comment...",
                                filled: true,
                                fillColor: Color(0xfff3f4f6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          state.addState == RequestState.loading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: () {
                                      if (comt.text.isEmpty) {
                                        AppTopSnackBar.error(
                                          context,
                                          message: "Comment cannot be empty",
                                        );
                                        return;
                                      }

                                      context.read<CommentBloc>().add(
                                        AddCommentEvent(
                                          postId: postId,
                                          commentText: comt.text,
                                          userId: user.id,
                                          userImage: user.imageUrl ?? '',
                                          userName: user.fullName,
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
