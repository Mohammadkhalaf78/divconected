import 'package:dev_connected/core/enums/enum.dart';
import 'package:dev_connected/features/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.userName,
    required super.isEmailVerified,
    required super.role,
    required super.phone,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'isEmailVerified': isEmailVerified,

      'role': role.name,
      'phone': phone,
      'createdAt': createdAt,
    };
  }

  // 🔥 Firestore → object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      userName: map['userName'],
      isEmailVerified: map['isEmailVerified'],


      // String → enum
      role: UserRole.values.firstWhere((e) => e.name == map['role']),

      phone: map['phone'],
      createdAt: map['createdAt'],
    );
  }
}
