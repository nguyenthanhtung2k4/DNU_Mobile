import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/customer_model.dart';

class LocalStore {
  static const String _userKey = 'current_user';

  static Future<void> saveUser(CustomerModel user) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert to map, then date objects to string for JSON encoding if needed.
    // However, CustomerModel.toMap converts DateTime to Timestamp, which jsonEncode cannot handle directly.
    // We need a proper clean Json serialization. For now, simple manual map.
    
    final map = {
      'id': user.id,
      'fullName': user.fullName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'address': user.address,
      'preferences': user.preferences,
      'loyaltyPoints': user.loyaltyPoints,
      'createdAt': user.createdAt.toIso8601String(),
      'isActive': user.isActive,
    };
    
    await prefs.setString(_userKey, jsonEncode(map));
  }

  static Future<CustomerModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_userKey);
    if (str == null) return null;

    try {
      final map = jsonDecode(str) as Map<String, dynamic>;
      return CustomerModel(
        id: map['id'],
        email: map['email'],
        fullName: map['fullName'],
        phoneNumber: map['phoneNumber'],
        address: map['address'],
        preferences: List<String>.from(map['preferences']),
        loyaltyPoints: map['loyaltyPoints'],
        createdAt: DateTime.parse(map['createdAt']),
        isActive: map['isActive'],
      );
    } catch (e) {
      return null;
    }
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
