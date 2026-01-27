import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String itemId;
  final String itemName;
  final int quantity;
  final double price;

  OrderItem({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      itemId: map['itemId'],
      itemName: map['itemName'],
      quantity: map['quantity'],
      price: (map['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'quantity': quantity,
      'price': price,
    };
  }
}

class ReservationModel {
  final String id;
  final String customerId;
  final DateTime reservationDate;
  final int numberOfGuests;
  final String? tableNumber;
  final String status;
  final String? specialRequests;
  final List<OrderItem> orderItems;
  final double subtotal;
  final double serviceCharge;
  final double discount;
  final double total;
  final String? paymentMethod;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReservationModel({
    required this.id,
    required this.customerId,
    required this.reservationDate,
    required this.numberOfGuests,
    this.tableNumber,
    required this.status,
    this.specialRequests,
    required this.orderItems,
    required this.subtotal,
    required this.serviceCharge,
    required this.discount,
    required this.total,
    this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReservationModel.fromMap(
      String id, Map<String, dynamic> map) {
    return ReservationModel(
      id: id,
      customerId: map['customerId'] ?? '',
      reservationDate: map['reservationDate'] != null
          ? (map['reservationDate'] as Timestamp).toDate()
          : DateTime.now(),
      numberOfGuests: map['numberOfGuests'] ?? 1,
      tableNumber: map['tableNumber'],
      status: map['status'] ?? 'pending',
      specialRequests: map['specialRequests'],
      orderItems: (map['orderItems'] as List<dynamic>? ?? [])
          .map((e) => OrderItem.fromMap(e))
          .toList(),
      subtotal: (map['subtotal'] as num? ?? 0).toDouble(),
      serviceCharge:
          (map['serviceCharge'] as num? ?? 0).toDouble(),
      discount: (map['discount'] as num? ?? 0).toDouble(),
      total: (map['total'] as num? ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'],
      paymentStatus: map['paymentStatus'] ?? 'unpaid',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'reservationDate':
          Timestamp.fromDate(reservationDate),
      'numberOfGuests': numberOfGuests,
      'tableNumber': tableNumber,
      'status': status,
      'specialRequests': specialRequests,
      'orderItems': orderItems.map((e) => e.toMap()).toList(),
      'subtotal': subtotal,
      'serviceCharge': serviceCharge,
      'discount': discount,
      'total': total,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
