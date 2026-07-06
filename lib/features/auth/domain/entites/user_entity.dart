import 'package:dev_connected/core/enums/enum.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String userName;
  final String? profileImage;
  final bool isEmailVerified;
  final UserRole role;
  final String? phone;
  final String createdAt;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userName,
    this.profileImage,
    required this.isEmailVerified,
    required this.role,
    this.phone,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    userName,
    profileImage,
    isEmailVerified,
    role,
    phone,
  ];
}
