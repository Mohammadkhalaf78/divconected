import 'dart:io';

import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/profile/presntation/bloc/profile_bloc.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/account_settings_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/change_password_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/edit_profile_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/image_picker_bottom_sheet.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/account_row.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/info_card.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/widgets/logout_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// Design tokens used across the Profile feature screens.
const Color kBackground = Color(0xFFF7F7FC);

class ProfileViewScreen extends StatelessWidget {
  ProfileViewScreen({super.key});
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(sl(), sl(), sl())..add(GetProfileRequested()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.profileState == RequestState.error) {
            AppTopSnackBar.error(context, message: state.profileMessage);
          }
        },
        builder: (context, state) {
          // Safely handle nullable userProfile and createdAt.
          final userProfile = state.userProfile; // may be null
          final createdAt =
              DateTime.tryParse(userProfile?.createdAt ?? '') ?? DateTime.now();
          final joinedDate = DateFormat('dd MMM yyyy').format(createdAt);

          return state.profileState == RequestState.loading
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
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
                              builder: (context) =>
                                  const AccountSettingsScreen(),
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
                                  userProfile?.imageUrl ?? 'https://www.gravatar.com/avatar/placeholder'
                                    ,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    // Handle avatar change
                                    ProfileImageBottomSheet.show(
                                      context,
                                      onCameraTap: () async {
                                        // Open Camera

                                        final pickedFile = await _picker
                                            .pickImage(
                                              source: ImageSource.camera,
                                            );

                                        if (pickedFile != null) {
                                          final image = File(pickedFile.path);

                                          // ignore: use_build_context_synchronously
                                          context.read<ProfileBloc>().add(
                                            UpdateProfileImageRequested(image),
                                          );

                                          // Navigator.pop(context);
                                        }
                                      },
                                      onGalleryTap: () async {
                                        final pickedFile = await _picker
                                            .pickImage(
                                              source: ImageSource.gallery,
                                            );

                                        if (pickedFile != null) {
                                          final image = File(pickedFile.path);

                                          // ignore: use_build_context_synchronously
                                          context.read<ProfileBloc>().add(
                                            UpdateProfileImageRequested(image),
                                          );
                                        }
                                      },
                                      onRemoveTap: () {
                                        // Delete Image
                                      },
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
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorsManager.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.primary.withValues(alpha: 0.1),
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

                        // create bio here
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(32, 107, 114, 128),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            userProfile?.bio ?? '',
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Info cards
                        InfoCard(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: userProfile?.email ?? 'ahmed@example.com',
                        ),
                        const SizedBox(height: 12),
                        InfoCard(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: userProfile?.phone ?? '',
                        ),
                        const SizedBox(height: 12),
                        InfoCard(
                          icon: Icons.calendar_today_outlined,
                          label: 'Member Since',
                          value: joinedDate,
                        ),
                        const SizedBox(height: 12),
                        InfoCard(
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

                        AccountRow(
                          icon: Icons.edit_outlined,
                          title: 'Edit Profile',
                          subtitle: 'Update your personal info',
                          onTap: () {
                            // Handle navigation to Edit Profile screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(
                                  userProfile: userProfile!,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        AccountRow(
                          icon: Icons.lock_outline,
                          title: 'Change Password',
                          subtitle: 'Update your password',
                          onTap: () {
                            // Handle navigation to Change Password screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        AccountRow(
                          icon: Icons.settings_outlined,
                          title: 'Account Settings',
                          subtitle: 'Manage your preferences',
                          onTap: () {
                            // Handle navigation to Account Settings screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AccountSettingsScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        AccountRow(
                          icon: Icons.logout_outlined,
                          title: 'Logout',
                          subtitle: 'Sign out of your account',
                          onTap: () {
                            // Handle navigation to Account Settings screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LogoutConfirmationScreen(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
