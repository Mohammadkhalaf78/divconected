import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/home_feed/presntation/bloc/home_feed_bloc.dart';
import 'package:dev_connected/features/home_feed/presntation/screens/create_post_page.dart';
import 'package:dev_connected/features/home_feed/presntation/screens/post_card.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final UserEntity? user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeFeedBloc(sl())..add(LoadPostsRequested()),
      child: BlocConsumer<HomeFeedBloc, HomeFeedState>(
        listener: (context, state) {
          if (state.getPostsState == RequestState.error) {
            AppTopSnackBar.error(context, message: state.getPostsMessage);
          }
        },
        builder: (context, state) {
          final posts = state.currentPosts;

          return state.getPostsState == RequestState.loading
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  backgroundColor: const Color(0xFFF5F6F8),
                  appBar: _HomeAppBar(user?.imageUrl ?? ''),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePostPage(user: user),
                        ),
                      );
                    },
                    backgroundColor:ColorsManager.secondary,
                    elevation: 2,
                    child: const Icon(Icons.add, color: Colors.white, size: 30),
                  ),

                  body: RefreshIndicator(
                    onRefresh: () async {
                      context.read<HomeFeedBloc>().add(LoadPostsRequested());
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _GreetingText(
                                  userName: user?.fullName ?? 'User',
                                ),
                                SizedBox(height: 16),
                                _SearchBar(),
                                SizedBox(height: 16),
                                _CreatePostCard(
                                  userName: user?.fullName ?? 'User',
                                  imageUrl: user?.imageUrl ?? '',
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                        if (posts == null || posts.isEmpty)
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(child: Text('No posts yet')),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => PostCard(post: posts[index]),
                              childCount: posts.length,
                            ),
                          ),
                        const SliverToBoxAdapter(child: SizedBox(height: 90)),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top app bar: user avatar - "</> Dev Connected" logo - notification bell
// ---------------------------------------------------------------------------
class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar(this.imageUrl);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5F6F8),
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      leadingWidth: 56,
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFD9D9D9),
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ColorsManager.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.code_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Dev Connected',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ---------------------------------------------------------------------------
// "Good Morning 👋, Welcome back, {userName}"
// ---------------------------------------------------------------------------
class _GreetingText extends StatelessWidget {
  final String userName;
  const _GreetingText({required this.userName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          height: 1.25,
        ),
        children: [TextSpan(text: 'Welcome back, $userName 👋')],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Search bar
// ---------------------------------------------------------------------------
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 15),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
        filled: true,
        fillColor: const Color(0xFFE9EAEC),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// "Create Post" card
// ---------------------------------------------------------------------------
class _CreatePostCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  const _CreatePostCard({required this.userName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create Post',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    'Share something...',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Post',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
