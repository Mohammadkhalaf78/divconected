import 'package:dev_connected/core/constance/widgets/app_button_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_text_form_filed.dart';
import 'package:dev_connected/core/constance/widgets/app_top_snackbar.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/auth/presntaion/controller/bloc/auth_controller_bloc.dart';
import 'package:dev_connected/features/auth/presntaion/screens/fotgot_password_screen.dart';
import 'package:dev_connected/features/auth/presntaion/screens/register_screen.dart';
import 'package:dev_connected/features/profile/presntation/screens/profile_screen/profile_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => AuthBloc(sl(), sl(), sl(), sl(), sl()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.logInState == RequestState.error) {
            AppTopSnackBar.error(context, message: state.loginMessage);
          } else if (state.logInState == RequestState.loaded) {
            AppTopSnackBar.success(context, message: 'Login Successful');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  ProfileViewScreen(),
              ),
            );
          } else if (state.signInWithGoogleState == RequestState.error) {
            AppTopSnackBar.error(
              context,
              message: state.signinWithGoogleMessage,
            );
          } else if (state.signInWithGoogleState == RequestState.loaded) {
            AppTopSnackBar.success(
              context,
              message: 'Login with Google Successful',
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  ProfileViewScreen(),
              ),
            );
          } else if (state.signInWithGoogleState == RequestState.loading) {
            AppTopSnackBar.info(context, message: 'Logging in with Google...');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorsManager.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 360,

                        child: Image.asset(
                          'assets/images/divconneted.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.black,
                              ),
                            ),

                            Text(
                              'Log in to continue to your journey',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorsManager.grey,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.black,
                              ),
                            ),
                            SizedBox(height: 8),

                            AppTextFormFiled(
                              controller: emailController,
                              hintText: 'Enter your email',
                              suffixIcons: Icon(Icons.email_outlined),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.black,
                              ),
                            ),

                            SizedBox(height: 8),

                            AppTextFormFiled(
                              isObscureText: !context
                                  .read<AuthBloc>()
                                  .isPasswordVisible,
                              controller: passwordController,
                              hintText: 'Enter your password',
                              suffixIcons: IconButton(
                                icon: Icon(Icons.visibility_off),
                                onPressed: () {
                                  // Handle password visibility toggle
                                  context
                                      .read<AuthBloc>()
                                      .togglePasswordVisibility();
                                },
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Handle forgot password button press
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: ColorsManager.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 12),
                            AppTextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              },
                              buttonText:
                                  state.logInState == RequestState.loading
                                  ? 'Logging in...'
                                  : 'Log In',
                            ),

                            SizedBox(height: 16),
                            // or continue with
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: ColorsManager.grey,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    'or continue with',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorsManager.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: ColorsManager.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16),

                            // Google only
                            InkWell(
                              onTap: () {
                                context.read<AuthBloc>().add(
                                  SignInWithGoogleRequested(),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Handle Google login button press
                                    },
                                    icon: Image.asset(
                                      'assets/images/google.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),

                                  Text(
                                    'Google',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorsManager.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorsManager.grey,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle sign up button press
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: ColorsManager.primary,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
