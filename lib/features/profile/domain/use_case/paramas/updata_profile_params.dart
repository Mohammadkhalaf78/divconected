class UpdateProfileParams {
  final String? fullName;
  final String? email;
  final String? phone;
  final String? bio;

  UpdateProfileParams({
    this.fullName,
    this.email,
    this.phone,
    this.bio,
  });

  factory UpdateProfileParams.fromMap(Map<String, dynamic> map) {
    return UpdateProfileParams(
      fullName: map['fullName'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      bio: map['bio'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (fullName != null) {
      map['fullName'] = fullName;
    }
    if (email != null) {
      map['email'] = email;
    }
    if (phone != null) {
      map['phone'] = phone;
    }
    if (bio != null) {
      map['bio'] = bio;
    }
    return map;
  }
}