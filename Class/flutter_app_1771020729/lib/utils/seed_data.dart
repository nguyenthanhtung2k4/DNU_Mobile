import 'dart:math';
import '../models/menu_item_model.dart';
import '../models/customer_model.dart';
import '../models/reservation_model.dart'; // Ensure this model exists and exports ReservationModel
import '../services/firestore_service.dart';

class SeedData {
  static final _service = FirestoreService.instance;
  static final _random = Random();

  static Future<void> seed() async {
    print("🌱 Starting Seed Data...");

    await _seedCustomers();
    await _seedMenuItems();
    await _seedReservations();

    print("✅ Seed Data Completed!");
  }

  // --- 1. SEED CUSTOMERS (5 users) ---
  static Future<void> _seedCustomers() async {
    // Force add without checking empty to ensure data exists
    // Hoặc có thể xóa dòng check này đi nếu muốn luôn luôn nạp.
    // Tuy nhiên để tránh duplicate ID nhiều lần, ta dùng set (overwrite) nên không sao.
    print("Adding sample customers...");
    final customersRef = _service.customersRef;

    final customers = [
      CustomerModel(id: 'cus_1', fullName: 'Nguyễn Văn A', email: 'a@gmail.com', phoneNumber: '0901234567', loyaltyPoints: 100, preferences: ['Thích cay'], address: 'Hà Nội', createdAt: DateTime.now(), isActive: true),
      CustomerModel(id: 'cus_2', fullName: 'Trần Thị B', email: 'b@gmail.com', phoneNumber: '0909876543', loyaltyPoints: 50, preferences: ['Không hành'], address: 'Đà Nẵng', createdAt: DateTime.now(), isActive: true),
      CustomerModel(id: 'cus_3', fullName: 'Lê Văn C', email: 'c@gmail.com', phoneNumber: '0912345678', loyaltyPoints: 200, preferences: ['Ăn chay'], address: 'HCM', createdAt: DateTime.now(), isActive: true),
      CustomerModel(id: 'cus_4', fullName: 'Phạm Thị D', email: 'd@gmail.com', phoneNumber: '0987654321', loyaltyPoints: 0, preferences: [], address: 'Hải Phòng', createdAt: DateTime.now(), isActive: true),
      CustomerModel(id: 'cus_5', fullName: 'Hoàng Văn E', email: 'e@gmail.com', phoneNumber: '0966778899', loyaltyPoints: 500, preferences: ['Thích ngọt'], address: 'Cần Thơ', createdAt: DateTime.now(), isActive: true),
    ];

    final batch = _service.db.batch();
    for (var c in customers) {
      batch.set(customersRef.doc(c.id), c.toMap());
    }
    await batch.commit();
    print("✅ Added 5 Customers");
  }

  // --- 2. SEED MENU ITEMS (20 items) ---
  static Future<void> _seedMenuItems() async {
    print("Adding sample menu items...");
    final menuRef = _service.menuItemsRef;

    final categories = ['Appetizer', 'Main Course', 'Dessert', 'Drink', 'Salad'];
    final batch = _service.db.batch();

    int count = 1;
    for (var cat in categories) {
      for (int i = 1; i <= 4; i++) {
        final id = 'menu_${count.toString().padLeft(3, '0')}';
        final item = MenuItemModel(
          id: id,
          name: '$cat Item $i',
          description: 'Delicious $cat number $i with special ingredients',
          category: cat,
          price: 50000.0 + (i * 10000),
          imageUrl: 'https://placehold.co/400x300?text=$cat+$i', // Placeholder image
          ingredients: ['Ingredient A', 'Ingredient B', 'Spices'],
          isVegetarian: i % 2 == 0, // Random logic
          isSpicy: i % 3 == 0,
          preparationTime: 10 + i * 2,
          isAvailable: true,
          rating: 4.0 + (i * 0.2), // 4.2, 4.4, ...
          createdAt: DateTime.now(),
        );
        batch.set(menuRef.doc(id), item.toMap());
        count++;
      }
    }
    await batch.commit();
    print("✅ Added 20 Menu Items");
  }

  // --- 3. SEED RESERVATIONS (10 reservations) ---
  static Future<void> _seedReservations() async {
    print("Adding sample reservations...");
    final resRef = _service.reservationsRef;

    final statuses = ['pending', 'confirmed', 'seated', 'completed', 'cancelled'];
    final batch = _service.db.batch();

    for (int i = 1; i <= 10; i++) {
        final id = 'res_${i.toString().padLeft(3, '0')}';
        final status = statuses[i % statuses.length];
        
        // Mock order items
        final orderItem = OrderItem(itemId: 'menu_001', itemName: 'Appetizer Item 1', quantity: 2, price: 60000);
        
        final res = ReservationModel(
          id: id,
          customerId: 'cus_${(i % 5) + 1}', // Cycle through customers
          reservationDate: DateTime.now().add(Duration(days: i)),
          numberOfGuests: 2 + (i % 4),
          tableNumber: status == 'seated' || status == 'completed' ? 'T-$i' : null,
          status: status,
          specialRequests: i % 2 == 0 ? 'Gần cửa sổ' : null,
          orderItems: status == 'pending' ? [] : [orderItem], // Pending might not have items yet
          subtotal: status == 'pending' ? 0 : 120000,
          serviceCharge: status == 'pending' ? 0 : 12000,
          discount: 0,
          total: status == 'pending' ? 0 : 132000,
          paymentMethod: status == 'completed' ? 'Cash' : null,
          paymentStatus: status == 'completed' ? 'paid' : 'unpaid',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
       batch.set(resRef.doc(id), res.toMap());
    }
    await batch.commit();
     print("✅ Added 10 Reservations");
  }
}
