import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/profile_view_screen.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);
const Color kSuccessGreen = Color(0xFF22C55E);

class UpdateProfileSuccessScreen extends StatelessWidget {
  const UpdateProfileSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: kSuccessGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: kSuccessGreen,
                  size: 56,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Profile Updated!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your profile has been updated successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kTextGray),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle back to profile button press
                      Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  ProfileViewScreen(),
              ),
            );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Back to Profile',
                    style: TextStyle(
                      color: ColorsManager.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
