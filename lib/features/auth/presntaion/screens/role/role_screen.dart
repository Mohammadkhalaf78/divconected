import 'package:dev_connected/core/constance/widgets/app_button_filed.dart';
import 'package:dev_connected/core/constance/widgets/colors_manager.dart';
import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/auth/presntaion/screens/login_screen.dart';
import 'package:dev_connected/features/auth/presntaion/screens/register_screen.dart';
import 'package:dev_connected/core/constance/widgets/app_logo.dart';
import 'package:dev_connected/features/auth/presntaion/screens/role/role_card.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool devSelcted = true;
  bool comSelcted = false;
  UserRole selectedRole = UserRole.developer; // Set this to the desired role

  // Set this to true or false based on your logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(),
            
            
              const SizedBox(height: 35),
              const Text(
                ' Choose Your \n account type  ',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.black,
                ),
              ),

              SizedBox(height: 20),

              Text(
                'select how you want to use \n          DevConnected ',
                style: TextStyle(fontSize: 22, color: ColorsManager.grey),
              ),

              SizedBox(height: 40),

              RoleCard(
                isSelcted: devSelcted,
                role: UserRole.developer,
                icon: Icon(
                  Icons.terminal,
                  color: ColorsManager.white,
                  size: 40,
                ),
                description: 'Finds jobs and connects with developers',
                onTap: () {
                  // Handle role card tap
                  setState(() {
                    // Update the selected state when the developer role is tapped
                    devSelcted = true;
                    comSelcted = false;
                    // You can implement your logic here to change the selected role
                    selectedRole =
                        UserRole.developer; // Update the selected role
                  });
                },
              ),
              const SizedBox(height: 20),
              RoleCard(
                isSelcted: comSelcted,
                role: UserRole.company,
                icon: Icon(
                  Icons.business,
                  color: ColorsManager.white,
                  size: 40,
                ),
                description: 'Posts jobs and connects with developers',
                onTap: () {
                  setState(() {
                    // Update the selected state when the company role is tapped
                    devSelcted = false;
                    comSelcted = true;
                    // You can implement your logic here to change the selected role
                    selectedRole = UserRole.company; // Update the selected role
                  });
                  // Handle role card tap
                },
              ),

              SizedBox(height: 70),

              AppTextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(
                        selectedRole: selectedRole, // Pass the selected role
                      ),
                    ),
                  );
                },
                buttonText: 'Continue',
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16, color: ColorsManager.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle Terms of Service and Privacy Policy link tap
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen(), // Replace with your login screen widget[]
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorsManager.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

