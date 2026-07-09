import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/home_feed/presntation/bloc/home_feed_bloc.dart';
import 'package:dev_connected/features/home_feed/presntation/screens/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6F8),
            appBar: _HomeAppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFF3B82F6),
              elevation: 2,
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
            bottomNavigationBar: const _HomeBottomNavBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeFeedBloc>().add(LoadPostsRequested());
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _GreetingText(userName: 'Mohamed'),
                          SizedBox(height: 16),
                          _SearchBar(),
                          SizedBox(height: 16),
                          _CreatePostCard(userName: 'Mohamed'),
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
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF5F6F8),
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      leadingWidth: 56,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFD9D9D9),
          backgroundImage: AssetImage('assets/images/profile_defult.jpg'),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
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
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          height: 1.25,
        ),
        children: [
          const TextSpan(text: 'Good Morning 👋, '),
          TextSpan(text: 'Welcome back, $userName'),
        ],
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
  final String userName;
  const _CreatePostCard({required this.userName});

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
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: AssetImage('assets/images/profile_defult.jpg'),
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

// ---------------------------------------------------------------------------
// Bottom navigation bar
// ---------------------------------------------------------------------------
class _HomeBottomNavBar extends StatelessWidget {
  const _HomeBottomNavBar();

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF3B82F6);
    const inactiveColor = Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _NavBarItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isActive: true,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _NavBarItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                isActive: false,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _NavBarItem(
                icon: Icons.add_circle_outline,
                label: 'Create',
                isActive: false,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _NavBarItem(
                icon: Icons.mail_outline_rounded,
                label: 'Messages',
                isActive: false,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _NavBarItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                isActive: false,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
