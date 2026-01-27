import '../models/customer_model.dart';
import '../services/firestore_service.dart';

class CustomerRepository {
  final _service = FirestoreService.instance;

  /// Thêm customer
  Future<void> addCustomer(CustomerModel customer) async {
    await _service.customersRef
        .doc(customer.id)
        .set(customer.toMap());
  }

  /// Lấy customer theo ID
  Future<CustomerModel?> getCustomerById(String id) async {
    final doc =
        await _service.customersRef.doc(id).get();
    if (!doc.exists) return null;
    return CustomerModel.fromMap(doc.id, doc.data()!);
  }

  /// Lấy tất cả customers (real-time)
  Stream<List<CustomerModel>> getAllCustomers() {
    return _service.customersRef.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) =>
                  CustomerModel.fromMap(
                      doc.id, doc.data()))
              .toList(),
        );
  }

  /// Update customer
  Future<void> updateCustomer(CustomerModel customer) async {
    await _service.customersRef
        .doc(customer.id)
        .update(customer.toMap());
  }

  /// Update loyaltyPoints
  Future<void> updateLoyaltyPoints(
      String customerId, int points) async {
    await _service.customersRef
        .doc(customerId)
        .update({'loyaltyPoints': points});
  }

  /// Check Login (Email hoặc Phone)
  Future<CustomerModel?> checkLogin(String query) async {
    // 1. Check Phone
    var snap = await _service.customersRef
        .where('phoneNumber', isEqualTo: query)
        .limit(1)
        .get();
    
    if (snap.docs.isNotEmpty) {
      return CustomerModel.fromMap(
          snap.docs.first.id, snap.docs.first.data());
    }

    // 2. Check Email
    snap = await _service.customersRef
        .where('email', isEqualTo: query)
        .limit(1)
        .get();

    if (snap.docs.isNotEmpty) {
      return CustomerModel.fromMap(
          snap.docs.first.id, snap.docs.first.data());
    }

    return null;
  }
}
