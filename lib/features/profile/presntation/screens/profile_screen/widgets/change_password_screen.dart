import 'package:dev_connected/core/constance/widgets/app_button_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:flutter/material.dart';

const Color kPrimaryPurple = Color(0xFF6C63FF);
const Color kBackground = Color(0xFFF7F7FC);
const Color kTextDark = Color(0xFF1F1F2E);
const Color kTextGray = Color(0xFF6B7280);
const Color kSuccessGreen = Color(0xFF22C55E);

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

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
          'Change Password',
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
            const SizedBox(height: 16),

            // Icon badge
            Center(
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: kPrimaryPurple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: kPrimaryPurple,
                  size: 40,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _FieldLabel('Current Password'),
            const SizedBox(height: 8),
            AppTextFormFiled(
              controller: currentPasswordController,
              isObscureText: true,
              hintText: 'Enter current password',
              suffixIcons: const Icon(Icons.visibility_off),
            ),

            const SizedBox(height: 16),
            _FieldLabel('New Password'),
            const SizedBox(height: 8),
            AppTextFormFiled(
              controller: newPasswordController,
              isObscureText: true,
              hintText: 'Enter new password',
              suffixIcons: const Icon(Icons.visibility_off),
            ),

            const SizedBox(height: 16),
            _FieldLabel('Confirm New Password'),
            const SizedBox(height: 8),
            AppTextFormFiled(
              controller: confirmPasswordController,
              isObscureText: true,
              hintText: 'Re-enter new password',
              suffixIcons: const Icon(Icons.visibility_off),
            ),

            const SizedBox(height: 16),

            // Password requirements checklist
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: newPasswordController,
              builder: (context, value, _) {
                final password = value.text;
                final hasMinLength = password.length >= 8;
                final hasUppercase = password.contains(RegExp(r'[A-Z]'));
                final hasNumber = password.contains(RegExp(r'[0-9]'));
                final hasSpecialChar = password.contains(
                  RegExp(r'[!@#\$&*~%^()_+=-]'),
                );

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kPrimaryPurple.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password must contain:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kTextDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _RequirementRow(
                        label: 'At least 8 characters',
                        isValid: hasMinLength,
                      ),
                      const SizedBox(height: 6),
                      _RequirementRow(
                        label: 'One uppercase letter',
                        isValid: hasUppercase,
                      ),
                      const SizedBox(height: 6),
                      _RequirementRow(label: 'One number', isValid: hasNumber),
                      const SizedBox(height: 6),
                      _RequirementRow(
                        label: 'One special character',
                        isValid: hasSpecialChar,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            AppTextButton(
              onPressed: () {
                // Handle update password button press
              },
              buttonText: 'Update Password',
            ),

            const SizedBox(height: 24),
          ],
        ),
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

class _RequirementRow extends StatelessWidget {
  final String label;
  final bool isValid;

  const _RequirementRow({required this.label, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isValid ? kSuccessGreen : const Color(0xFF9CA3AF),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isValid ? kSuccessGreen : const Color(0xFF9CA3AF),
            fontWeight: isValid ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
