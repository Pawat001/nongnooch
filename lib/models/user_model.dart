import 'package:cloud_firestore/cloud_firestore.dart';

/// User Model สำหรับผู้ใช้งานระบบ
class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String nationality; // 'thai' or 'foreigner'
  final String? idCardNumber; // เลขบัตรประชาชน (สำหรับคนไทย)
  final String? passportNumber; // เลขพาสปอร์ต (สำหรับชาวต่างชาติ)
  final String kycStatus; // 'pending', 'verified', 'rejected'
  final String role; // 'guest', 'user', 'vip'
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.nationality,
    this.idCardNumber,
    this.passportNumber,
    this.kycStatus = 'pending',
    this.role = 'user',
    this.profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
  
  // Check if user has birthday this month
  bool get hasBirthdayThisMonth {
    final now = DateTime.now();
    return dateOfBirth.month == now.month;
  }
  
  // Check if user is Thai national
  bool get isThaiNational {
    return nationality.toLowerCase() == 'thai';
  }
  
  // Check if KYC is verified
  bool get isKYCVerified {
    return kycStatus == 'verified';
  }
  
  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'nationality': nationality,
      'idCardNumber': idCardNumber,
      'passportNumber': passportNumber,
      'kycStatus': kycStatus,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
  
  // Create from Firestore document
  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      dateOfBirth: (data['dateOfBirth'] as Timestamp?)?.toDate() ?? DateTime.now(),
      nationality: data['nationality'] ?? 'thai',
      idCardNumber: data['idCardNumber'],
      passportNumber: data['passportNumber'],
      kycStatus: data['kycStatus'] ?? 'pending',
      role: data['role'] ?? 'user',
      profileImageUrl: data['profileImageUrl'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  
  // Copy with method
  UserModel copyWith({
    String? email,
    String? fullName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? nationality,
    String? idCardNumber,
    String? passportNumber,
    String? kycStatus,
    String? role,
    String? profileImageUrl,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationality: nationality ?? this.nationality,
      idCardNumber: idCardNumber ?? this.idCardNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      kycStatus: kycStatus ?? this.kycStatus,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
