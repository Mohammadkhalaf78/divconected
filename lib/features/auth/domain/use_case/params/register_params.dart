

import 'package:dev_connected/core/enums/enum.dart';

class RegisterParams {
  final String email;
  final String password;
  final String fullName;
  final String phone;
  final String createdAt;
  final String imageUrl;
  final UserRole role;

  RegisterParams({
    required this.email,
    required this.password,
    required this.fullName, 
    required this.phone,
    required this.createdAt ,
    required this.role,
    required this.imageUrl,
  });
}
