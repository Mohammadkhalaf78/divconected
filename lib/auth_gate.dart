import 'package:dev_connected/core/constance/widgets/app_logo.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/core/services/service_locator.dart';
import 'package:dev_connected/features/auth/presntaion/controller/bloc/auth_controller_bloc.dart';
import 'package:dev_connected/features/auth/presntaion/screens/login_screen.dart';
import 'package:dev_connected/features/main/screens/company_screen.dart';
import 'package:dev_connected/features/main/screens/developer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(sl(), sl(), sl(), sl(), sl(), sl())
            ..add(CheckCurrentUserRequested()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.checkCurrentUserState == RequestState.loaded) {
            if (state.currentUser != null) {
              // User is logged in, navigate to the home screen
              if (state.currentUser!.role == UserRole.company) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CompanyScreen(userEntity: state.currentUser!),
                  ),
                );
              } else {
                // Navigate to the appropriate screen for other user roles
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeveloperScreen(userEntity: state.currentUser!),
                  ),
                );
              }
            } else {
              // User is not logged in, navigate to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          }
        },

        child: const Scaffold(body: Center(child: AppLogo())),
      ),
    );
  }
}
