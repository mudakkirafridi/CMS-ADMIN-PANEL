class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String academicLevel;
  final String registrationNo;
  final bool termsAccepted;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.academicLevel,
    required this.registrationNo,
    required this.termsAccepted,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phone_no'] ?? '',
      academicLevel: map['academic_level'] ?? '',
      registrationNo: map['registration_no'] ?? '',
      termsAccepted: map['terms_accepted'] ?? false,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_no': phoneNo,
      'academic_level': academicLevel,
      'registration_no': registrationNo,
      'terms_accepted': termsAccepted,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
