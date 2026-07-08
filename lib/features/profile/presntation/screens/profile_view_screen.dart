import 'package:dev_connected/core/constance/colors_manager.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/profile/presntation/bloc/profile_bloc.dart';
import 'package:dev_connected/features/profile/presntation/screens/account_settings_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/change_password_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/edit_profile_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/image_picker_bottom_sheet.dart';
import 'package:dev_connected/features/profile/presntation/screens/logout_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Design tokens used across the Profile feature screens.
const Color kBackground = Color(0xFFF7F7FC);

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(sl(),sl())..add(GetProfileRequested()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
            // Safely handle nullable userProfile and createdAt.
            final userProfile = state.userProfile; // may be null
            final _createdAt = DateTime.tryParse(userProfile?.createdAt ?? '') ?? DateTime.now();
            final joinedDate = DateFormat('dd MMM yyyy').format(_createdAt);
          return Scaffold(
            backgroundColor: ColorsManager.white,
            appBar: AppBar(
              backgroundColor: kBackground,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: ColorsManager.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // Handle settings button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountSettingsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: ColorsManager.black,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Avatar + camera badge
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          // e.g. CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl))
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/premium-photo/happy-man-ai-generated-portrait-user-profile_1119669-1.jpg',
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              // Handle avatar change
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ImagePickerBottomSheet(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: ColorsManager.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 22,
                                color: ColorsManager.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Name / handle / role
                  Text(
                    userProfile?.fullName ?? 'null',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userProfile?.email ?? '@mohamed.dev',
                    style: TextStyle(fontSize: 14, color: ColorsManager.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      userProfile?.role.name ?? 'Developer',
                      style: TextStyle(
                        color: ColorsManager.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Info cards
                  _InfoCard(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: userProfile?.email ?? 'ahmed@example.com',
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value:
                        userProfile?.phone ??
                        '+20 101 234 5678', // TODO: Replace with real data
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.calendar_today_outlined,
                    label: 'Member Since',
                    value: joinedDate,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: 'Cairo, Egypt',
                  ),

                  const SizedBox(height: 24),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _AccountRow(
                    icon: Icons.edit_outlined,
                    title: 'Edit Profile',
                    subtitle: 'Update your personal info',
                    onTap: () {
                      // Handle navigation to Edit Profile screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(userProfile: userProfile!),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _AccountRow(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    subtitle: 'Update your password',
                    onTap: () {
                      // Handle navigation to Change Password screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _AccountRow(
                    icon: Icons.settings_outlined,
                    title: 'Account Settings',
                    subtitle: 'Manage your preferences',
                    onTap: () {
                      // Handle navigation to Account Settings screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountSettingsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _AccountRow(
                    icon: Icons.logout_outlined,
                    title: 'Logout',
                    subtitle: 'Sign out of your account',
                    onTap: () {
                      // Handle navigation to Account Settings screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogoutConfirmationScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 4,
              selectedItemColor: ColorsManager.primary,
              unselectedItemColor: ColorsManager.grey,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                // Handle bottom nav tap
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_outline),
                  label: 'Jobs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ColorsManager.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: ColorsManager.grey),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AccountRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsManager.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorsManager.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: ColorsManager.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: ColorsManager.grey),
            ],
          ),
        ),
      ),
    );
  }
}
