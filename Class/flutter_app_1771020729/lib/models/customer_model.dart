import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String address;
  final List<String> preferences;
  final int loyaltyPoints;
  final DateTime createdAt;
  final bool isActive;

  CustomerModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.preferences,
    required this.loyaltyPoints,
    required this.createdAt,
    required this.isActive,
  });

  /// Firestore → Dart
  factory CustomerModel.fromMap(
      String id, Map<String, dynamic> map) {
    return CustomerModel(
      id: id,
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      preferences: List<String>.from(map['preferences'] ?? []),
      loyaltyPoints: map['loyaltyPoints'] ?? 0,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      isActive: map['isActive'] ?? true,
    );
  }

  /// Dart → Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'preferences': preferences,
      'loyaltyPoints': loyaltyPoints,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
    };
  }
}
