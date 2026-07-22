import 'package:dev_connected/core/constance/widgets/app_button_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/profile/domain/use_case/paramas/updata_profile_params.dart';
import 'package:dev_connected/features/profile/presntation/bloc/profile_bloc.dart';
import 'package:dev_connected/sherad/entites/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.userProfile});

  final UserEntity
  userProfile; // Assuming userprofile is a property in ProfileState
  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController(
      text: userProfile.fullName,
    );
    TextEditingController usernameController = TextEditingController(
      text: 'ahmed.dev',
    );
    TextEditingController emailController = TextEditingController(
      text: userProfile.email,
    );
    TextEditingController phoneController = TextEditingController(
      text: userProfile.phone ?? '+20 101 234 5678',
    );
    TextEditingController bioController = TextEditingController(text:userProfile.bio ?? ' ');

    return BlocProvider(
      create: (context) => ProfileBloc(sl(), sl(), sl()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.updateProfileState == RequestState.loaded) {
            AppTopSnackBar.success(
              context,
              message: 'Profile updated successfully',
            );
            // Navigator.pop(context); // Close the success screen
            Navigator.pop(context); // Close the success screen
          } else if (state.updateProfileState == RequestState.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.updataProfileMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kBackground,
            appBar: AppBar(
              backgroundColor: kBackground,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new, color: kTextDark),
              ),
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: kTextDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Avatar + change photo
                  Center(
                    child: Column(
                      children: [

                        userProfile.imageUrl != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(userProfile.imageUrl!),
                              )
                            :
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: kPrimaryPurple.withValues(
                            alpha: 0.1,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 45,
                            color: kPrimaryPurple,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            // Handle change photo button press (open image picker)
                          },
                          child: const Text(
                            'Change Photo',
                            style: TextStyle(
                              color: kPrimaryPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  _FieldLabel('Full Name'),
                  const SizedBox(height: 8),
                  AppTextFormFiled(
                    controller: fullNameController,
                    hintText: 'Enter your full name',
                  ),

                  const SizedBox(height: 16),
                  _FieldLabel('Username'),
                  const SizedBox(height: 8),
                  AppTextFormFiled(
                    controller: usernameController,
                    hintText: 'Enter your username',
                  ),

                  const SizedBox(height: 16),
                  _FieldLabel('Email'),
                  const SizedBox(height: 8),
                  AppTextFormFiled(
                    controller: emailController,
                    hintText: 'Enter your email',
                    // isEnabled: false, // Email is read-only in this screen
                  ),

                  const SizedBox(height: 16),
                  _FieldLabel('Phone'),
                  const SizedBox(height: 8),
                  AppTextFormFiled(
                    controller: phoneController,
                    hintText: 'Enter your phone number',
                  ),

                  const SizedBox(height: 16),
                  _FieldLabel('Bio'),
                  const SizedBox(height: 8),
                  AppTextFormFiled(
                    controller: bioController,
                    hintText: 'Tell us about yourself',
                    // maxLines: 3,
                  ),

                  const SizedBox(height: 28),

                  AppTextButton(
                    onPressed: () {
                      // Handle save changes button press
                      context.read<ProfileBloc>().add(
                        UpdateProfileRequested(
                          UpdateProfileParams(
                            fullName: fullNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            bio: bioController.text,
                          ),
                        ),
                      );
                    },
                    buttonText: 'Save Changes',
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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: kTextDark,
        ),
      ),
    );
  }
}
