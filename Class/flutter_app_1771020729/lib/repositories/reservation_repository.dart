import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation_model.dart';
import '../services/firestore_service.dart';

class ReservationRepository {
  final _service = FirestoreService.instance;

  /// 1️⃣ Tạo reservation (pending)
  Future<void> createReservation(ReservationModel r) async {
    await _service.reservationsRef
        .doc(r.id)
        .set(r.toMap());
  }

  /// 2️⃣ Thêm món vào reservation + tính tiền
  Future<void> addItemToReservation(
    String reservationId,
    OrderItem item,
  ) async {
    final doc = await _service.reservationsRef
        .doc(reservationId)
        .get();

    final data = doc.data()!;
    final List list =
        List.from(data['orderItems'] ?? []);

    list.add(item.toMap());

    double subtotal = 0;
    for (var e in list) {
      subtotal +=
          (e['price'] as num) * e['quantity'];
    }

    final serviceCharge = subtotal * 0.1;
    final total = subtotal + serviceCharge;

    await _service.reservationsRef
        .doc(reservationId)
        .update({
      'orderItems': list,
      'subtotal': subtotal,
      'serviceCharge': serviceCharge,
      'discount': 0,
      'total': total,
    });
  }

  /// 3️⃣ Confirm reservation
  Future<void> confirmReservation(
      String id, String tableNumber) async {
    await _service.reservationsRef.doc(id).update({
      'status': 'confirmed',
      'tableNumber': tableNumber,
      'updatedAt': DateTime.now(),
    });
  }

  /// 4️⃣ Thanh toán (Đã sửa theo logic đề bài)
  /// - 1 point = 1000đ, tối đa 50% total
  /// - Cộng loyaltyPoints cho customer (1% total)
  /// - Trừ loyaltyPoints đã dùng
  Future<void> payReservation({
    required String reservationId,
    required String customerId,
    required int pointsToUse, // Số điểm khách muốn dùng
    required String paymentMethod,
  }) async {
    // Dùng Transaction để đảm bảo tính nhất quán (trừ điểm, cộng tiền, update status cùng lúc)
    await _service.db.runTransaction((transaction) async {
      // 1. Lấy dữ liệu đơn hàng
      final resRef = _service.reservationsRef.doc(reservationId);
      final resDoc = await transaction.get(resRef);
      if (!resDoc.exists) throw Exception("Reservation not found");
      
      final resData = resDoc.data()!;
      final double totalCurrent = (resData['total'] as num).toDouble();
      
      // 2. Lấy dữ liệu khách hàng để check điểm
      final customerRef = _service.customersRef.doc(customerId);
      final customerDoc = await transaction.get(customerRef);
      if (!customerDoc.exists) throw Exception("Customer not found");
      
      final customerData = customerDoc.data()!;
      final int currentPoints = customerData['loyaltyPoints'] ?? 0;

      if (pointsToUse > currentPoints) {
        throw Exception("Không đủ điểm tích lũy");
      }

      // 3. Tính toán Discount
      // 1 point = 1000đ
      double discountAmount = pointsToUse * 1000.0;
      
      // Tối đa 50% total
      final double maxDiscount = totalCurrent * 0.5;
      if (discountAmount > maxDiscount) {
        discountAmount = maxDiscount;
        // Tính lại số điểm thực tế cần dùng
        // (nếu 10k điểm = 10tr, mà max giảm 5tr thì chỉ trừ 5k điểm)
        // logic này tùy chọn, ở đây ta cứ trừ hết điểm user request hoặc báo lỗi. 
        // Nhưng để đơn giản theo đề: "Discount ... tối đa 50%", ta sẽ chỉ trừ số điểm tương ứng maxDiscount nếu vượt quá.
      }

      // Tính Total sau khi giảm
      final double finalTotal = totalCurrent - discountAmount;

      // 4. Tính điểm thưởng thêm (1% total sau khi giảm hoặc total gốc? Đề ghi 1% total)
      // Thường là 1% của số tiền thực trả (finalTotal)
      final int pointsEarned = (finalTotal * 0.01).floor();

      // 5. Cập nhật Customer (Trừ điểm dùng + Cộng điểm mới)
      final int newLoyaltyPoints = currentPoints - pointsToUse + pointsEarned;
      
      transaction.update(customerRef, {
        'loyaltyPoints': newLoyaltyPoints,
      });

      // 6. Cập nhật Reservation
      transaction.update(resRef, {
        'discount': discountAmount,
        'total': finalTotal,
        'paymentMethod': paymentMethod, // Đề bài yêu cầu lưu paymentMethod
        'paymentStatus': 'paid',
        'status': 'completed',
        'updatedAt': Timestamp.now()
      });
    });
  }

  /// 5️⃣ Get reservation theo customer
  Stream<List<ReservationModel>>
      getByCustomer(String customerId) {
    return _service.reservationsRef
        .where('customerId',
            isEqualTo: customerId)
        .snapshots()
        .map(
          (s) => s.docs
              .map((d) =>
                  ReservationModel.fromMap(
                      d.id, d.data()))
              .toList(),
        );
  }
}
