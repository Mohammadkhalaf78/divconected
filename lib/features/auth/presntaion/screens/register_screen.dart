import 'package:dev_connected/core/constance/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/auth/presntaion/controller/bloc/auth_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthBloc(sl(), sl(),sl()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.registerState == RequestState.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.registerMessage)));
          } else if (state.registerState == RequestState.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F8FC),
            body: SafeArea(
              child: Column(
                children: [
                  // Header: back button + logo
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle back button press
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: ColorsManager.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'divconnected',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C5CE7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),

                            // Title
                            const Text(
                              'Create your account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F1F2E),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Subtitle
                            const Text(
                              'Let\'s get you started on your career journey.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // White card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: ColorsManager.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Full Name',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    controller: fullNameController,
                                    hintText: 'Jane Doe',
                                  ),

                                  const SizedBox(height: 20),

                                  const Text(
                                    'Email Address',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    controller: emailController,
                                    hintText: 'jane@example.com',
                                  ),

                                  const SizedBox(height: 20),

                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    isObscureText:
                                        !context
                                            .read<AuthBloc>()
                                            .isPasswordVisible,
                                    controller: passwordController,
                                    hintText: 'Enter your password',
                                    suffixIcons: IconButton(
                                      icon: const Icon(
                                        Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        // Handle password visibility toggle
                                        context
                                            .read<AuthBloc>()
                                            .togglePasswordVisibility();
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  // Password requirements checklist
                                  ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: passwordController,
                                    builder: (context, value, _) {
                                      final password = value.text;
                                      final hasMinLength =
                                          password.length >= 8;
                                      final hasUppercase = password.contains(
                                        RegExp(r'[A-Z]'),
                                      );
                                      final hasLowercase = password.contains(
                                        RegExp(r'[a-z]'),
                                      );
                                      final hasNumberOrSpecial = password
                                          .contains(
                                            RegExp(r'[0-9!@#\$&*~%^()_+=-]'),
                                          );

                                      return Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF6C5CE7,
                                          ).withOpacity(0.06),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Password must contain:',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: ColorsManager.black,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            _PasswordRequirementRow(
                                              label: 'At least 8 characters',
                                              isValid: hasMinLength,
                                            ),
                                            const SizedBox(height: 6),
                                            _PasswordRequirementRow(
                                              label: 'One uppercase letter',
                                              isValid: hasUppercase,
                                            ),
                                            const SizedBox(height: 6),
                                            _PasswordRequirementRow(
                                              label: 'One lowercase letter',
                                              isValid: hasLowercase,
                                            ),
                                            const SizedBox(height: 6),
                                            _PasswordRequirementRow(
                                              label:
                                                  'One number or special character',
                                              isValid: hasNumberOrSpecial,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  const Text(
                                    'Confirm Password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    isObscureText: true,
                                    controller: confirmPasswordController,
                                    hintText: 'Confirm your password',
                                  ),

                                  const SizedBox(height: 24),

                                  // Create Account gradient button
                                  Container(
                                    height: 54,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF6C5CE7),
                                          Color(0xFFA29BFE),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF6C5CE7)
                                              .withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                        onTap: () {
                                          context.read<AuthBloc>().add(
                                            RegisterRequested(
                                              
                                              email: emailController.text,
                                              password:
                                                  passwordController.text,
                                              
                                            ),
                                          );
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                state.registerState ==
                                                        RequestState.loading
                                                    ? 'Creating...'
                                                    : 'Create Account',
                                                style: const TextStyle(
                                                  color: ColorsManager.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                Icons.arrow_forward,
                                                color: ColorsManager.white,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Already have an account? Log In
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle log in button press
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                      color: Color(0xFF6C5CE7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
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

/// A single row in the password requirements checklist.
/// Shows a filled purple check icon when [isValid] is true,
/// or an empty gray circle otherwise.
class _PasswordRequirementRow extends StatelessWidget {
  final String label;
  final bool isValid;

  const _PasswordRequirementRow({
    required this.label,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isValid ? const Color(0xFF6C5CE7) : const Color(0xFF9CA3AF),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isValid ? const Color(0xFF6C5CE7) : const Color(0xFF9CA3AF),
            fontWeight: isValid ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}