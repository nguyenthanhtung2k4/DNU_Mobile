import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Singleton pattern (dùng chung 1 instance)
  FirestoreService._privateConstructor();
  static final FirestoreService instance =
      FirestoreService._privateConstructor();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseFirestore get db => _db;

  /// Collection: customers
  CollectionReference<Map<String, dynamic>> get customersRef =>
      _db.collection('customers');

  /// Collection: menu_items
  CollectionReference<Map<String, dynamic>> get menuItemsRef =>
      _db.collection('menu_items');

  /// Collection: reservations
  CollectionReference<Map<String, dynamic>> get reservationsRef =>
      _db.collection('reservations');
}
 