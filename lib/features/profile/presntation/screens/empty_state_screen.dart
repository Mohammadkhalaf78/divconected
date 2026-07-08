import 'package:dev_connected/core/constance/colors_manager.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

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
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: kPrimaryPurple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.work_outline,
                      color: kPrimaryPurple,
                      size: 48,
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      Icons.auto_awesome,
                      color: kPrimaryPurple,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'No Information Yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add your information to help others know more about you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kTextGray),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add information button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Add Information',
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
