import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/home_feed/domain/entites/posts_model.dart';
import 'package:dev_connected/features/home_feed/presntation/controller/bloc/home_feed_bloc.dart';
import 'package:dev_connected/features/home_feed/presntation/screens/comments_screen.dart/comment_screen.dart';
import 'package:dev_connected/features/home_feed/presntation/screens/home_page/widgets/menu_button.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

class PostCard extends StatelessWidget {
  final PostEntities post;
  final UserEntity user;  

  const PostCard({super.key, required this.post, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUserId = sl<FirebaseAuth>().currentUser?.uid;
    // final currentPost = state.currentPosts!.firstWhere(
    //   (element) => element.id == post.id,
    // );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha((.5 * 255).round()),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((.04 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),

            const SizedBox(height: 16),

            _buildPostContent(context),

            if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
              const SizedBox(height: 14),
              _buildPostImage(),
            ],

            const SizedBox(height: 14),

            _buildStats(context),

            const SizedBox(height: 12),

            Divider(color: colorScheme.outlineVariant),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                _ActionButton(
                  icon: post.likedBy.contains(currentUserId)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  text: post.likedBy.contains(currentUserId) ? "Liked" : "Like",
                  onPressed: () {
                    // Handle like button press
                    context.read<HomeFeedBloc>().add(
                      ToggleLikeRequested(
                        postId: post.id,
                        userId: sl<FirebaseAuth>().currentUser!.uid,
                        // Assuming the PostEntities has a 'userId' field
                      ),
                    );
                  },
                ),

                _ActionButton(
                  icon: Icons.mode_comment_outlined,
                  text: "Comment",
                  onPressed: () {
                    // Handle comment button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          CommentsScreen(postId: post.id, user: user,) ,
                      ),
                    );
                  },
                ),

                _ActionButton(icon: Icons.share_outlined, text: "Share"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleAvatar(
          radius: 24,

          backgroundImage: post.userImage.isNotEmpty
              ? NetworkImage(post.userImage)
              : null,

          child: post.userImage.isEmpty
              ? Text(
                  _getInitials(post.userName),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              : null,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                post.userName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 3),

              Row(
                children: [
                  Text(
                    user.role.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Text(
                    "• ${_formatDate()}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        MenuButton(
          // Pass any necessary parameters to the MenuButton if needed
          postId: post.id, // Assuming the PostEntities has an 'id' field
        ),
      ],
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ReadMoreText(
          post.content,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            height: 1.5,
          ),
          moreStyle: const TextStyle(
            color: ColorsManager.primary,
            fontWeight: FontWeight.bold,
          ),
          lessStyle: const TextStyle(
            color: ColorsManager.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPostImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),

      child: Image.network(
        post.imageUrl!,

        width: double.infinity,

        height: 220,

        fit: BoxFit.cover,

        errorBuilder: (context, error, stack) {
          return Container(
            height: 220,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (post.likesCount > 0)
          Row(
            children: [
              Icon(Icons.favorite, size: 16, color: theme.colorScheme.primary),

              const SizedBox(width: 4),

              Text("${post.likesCount}", style: theme.textTheme.bodySmall),
            ],
          ),

        const Spacer(),

        if (post.commentsCount > 0)
          Text(
            "${post.commentsCount} comments",
            style: theme.textTheme.bodySmall,
          ),
      ],
    );
  }

  String _getInitials(String name) {
    final words = name.split(" ");

    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return "${words[0][0]}${words[1][0]}".toUpperCase();
  }

  String _formatDate() {
    final diff = DateTime.now().difference(post.createdAt);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    }

    return "${diff.inDays}d ago";
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;

  const _ActionButton({required this.icon, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10),

      onTap: onPressed,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),

        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),

            const SizedBox(width: 6),

            Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
