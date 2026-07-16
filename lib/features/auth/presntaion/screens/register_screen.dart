import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/auth/presntaion/controller/bloc/auth_controller_bloc.dart';
import 'package:dev_connected/features/main/screens/company_screen.dart';
import 'package:dev_connected/features/main/screens/developer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.selectedRole});
  final UserRole selectedRole;

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthBloc(sl(), sl(), sl(), sl(), sl(),sl()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.registerState == RequestState.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.registerMessage)));
          } else if (state.registerState == RequestState.loaded) {
            AppTopSnackBar.success(
              context,
              message: 'Account created successfully',
            );
            if (state.currentUser!.role == UserRole.developer) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DeveloperScreen(userEntity: state.currentUser),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CompanyScreen(userEntity: state.currentUser),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F8FC),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'DevConnected',
                style: TextStyle(color: ColorsManager.primary),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // Header: back button + logo
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 8),

                            // Title
                            Text(
                              'Create ${selectedRole.name} account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.black,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Subtitle
                            Text(
                              selectedRole.name == 'Developer'
                                  ? 'Let\'s get you started on your career journey.'
                                  : 'Let\'s get you started on your business journey.',
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
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedRole.name == 'developer'
                                        ? 'Full Name'
                                        : 'Company Name',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    controller: fullNameController,
                                    hintText: selectedRole.name == 'developer'
                                        ? 'Jane Doe'
                                        : 'Acme Inc.',
                                  ),

                                  const SizedBox(height: 20),

                                  const Text(
                                    'Email ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    controller: emailController,
                                    hintText: selectedRole.name == 'developer'
                                        ? 'jane@example.com'
                                        : 'contact@acme.com',
                                  ),
                                  const SizedBox(height: 20),

                                  const Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextFormFiled(
                                    controller: phoneController,
                                    hintText: '123-456-7890',
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
                                    isObscureText: !context
                                        .read<AuthBloc>()
                                        .isPasswordVisible,
                                    controller: passwordController,
                                    hintText: 'Enter your password',
                                    suffixIcons: IconButton(
                                      icon: const Icon(Icons.visibility_off),
                                      onPressed: () {
                                        // Handle password visibility toggle
                                        context
                                            .read<AuthBloc>()
                                            .togglePasswordVisibility();
                                      },
                                    ),
                                  ),

                                  // Password requirements checklist
                                  const SizedBox(height: 20),

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
                                          color: const Color(
                                            0xFF6C5CE7,
                                          ).withValues(alpha: 0.1),
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
                                            RegisterRequested(
                                              phone: phoneController.text,
                                              fullName: fullNameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              role: selectedRole,
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
