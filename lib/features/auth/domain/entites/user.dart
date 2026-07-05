import 'package:dev_connected/core/enums/enum.dart';
import 'package:equatable/equatable.dart';


class AuthUser extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String userName;
  final String? profileImage;
  final bool isEmailVerified;
  final UserRole role;

  const AuthUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userName,
    this.profileImage,
    required this.isEmailVerified,
    required this.role,
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
  ];
}
