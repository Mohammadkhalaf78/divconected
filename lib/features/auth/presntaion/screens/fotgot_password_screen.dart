import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/auth/presntaion/controller/bloc/auth_controller_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthBloc(sl(), sl(),sl(),sl(),sl(),sl()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.forgotPasswordState == RequestState.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.forgotPasswordMessage)));
          } else if (state.forgotPasswordState == RequestState.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reset link sent successfully')),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F8FC),
            body: SafeArea(
              child: Column(
                children: [
                  // Back button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(55, 78, 70, 229),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(33, 171, 85, 247),

                                blurRadius: 6,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Handle back button press
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: ColorsManager.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Back to Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.primary,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // Illustration: gradient lock icon with floating envelope
                            Center(
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Soft abstract wave/blur shape in background
                                    Container(
                                      height: 180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(
                                              0xFF6C5CE7,
                                            ).withValues(alpha: 0.10),
                                            const Color(
                                              0xFFA29BFE,
                                            ).withValues(alpha: 0.05),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),

                                    // Floating email envelope icon (behind)
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: ColorsManager.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.08,
                                              ),
                                              blurRadius: 12,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.email_outlined,
                                          color: Color(0xFFA29BFE),
                                          size: 22,
                                        ),
                                      ),
                                    ),

                                    // Main gradient lock icon
                                    Container(
                                      height: 110,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF6C5CE7),
                                            Color(0xFFA29BFE),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFF6C5CE7,
                                            ).withValues(alpha: 0.08),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.lock_outline,
                                        color: ColorsManager.white,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Title
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F1F2E),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Subtitle
                            const Text(
                              'No worries! Enter your email and we\'ll send you a link to reset your password.',
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Color(0xFF6B7280),
                              ),
                            ),

                            const SizedBox(height: 32),

                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.black,
                              ),
                            ),
                            const SizedBox(height: 8),

                            AppTextFormFiled(
                              controller: emailController,
                              hintText: 'Enter your email',
                              suffixIcons: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF6C5CE7),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Primary gradient button
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
                                    color: const Color(
                                      0xFF6C5CE7,
                                    ).withValues(alpha: 0.08),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14),
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      ForgotPasswordRequested(
                                        email: emailController.text,
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      state.forgotPasswordState ==
                                              RequestState.loading
                                          ? 'Sending...'
                                          : 'Send Reset Link',
                                      style: const TextStyle(
                                        color: ColorsManager.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Back to Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Remember your password?',
                                  style: TextStyle(
                                    color: ColorsManager.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                
                                TextButton(
                                  onPressed: () {
                                    // Handle back to login button press
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Back to Login',
                                    style: TextStyle(
                                      color: Color(0xFF6C5CE7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
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
