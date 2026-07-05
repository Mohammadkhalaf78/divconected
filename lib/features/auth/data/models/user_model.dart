import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/auth/domain/entites/user.dart';

class UserModel extends AuthUser {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.userName,
    required super.isEmailVerified,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String,
      isEmailVerified: json['isEmailVerified'] as bool,
      role: json['role'] as UserRole,
    );
  }
}
