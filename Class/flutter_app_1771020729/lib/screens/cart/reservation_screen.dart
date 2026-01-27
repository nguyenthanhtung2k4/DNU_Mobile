import 'package:flutter/material.dart';
import '../../services/local_store.dart';
import '../../models/reservation_model.dart';
import '../../repositories/reservation_repository.dart';
import '../cart/cart_screen.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _guestsCtrl = TextEditingController(text: '2');
  final _noteCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      final user = await LocalStore.getUser();
      if (user == null) throw Exception("Chưa đăng nhập");

      final fullDate = DateTime(
        _selectedDate.year, _selectedDate.month, _selectedDate.day,
        _selectedTime.hour, _selectedTime.minute
      );
      
      // Convert CartItems to OrderItems
      final orderItems = CartScreen.cartItems.map((c) => OrderItem(
        itemId: c.item.id,
        itemName: c.item.name,
        quantity: c.quantity,
        price: c.item.price,
      )).toList();

      // Calc totals
      double subtotal = 0;
      for (var o in orderItems) {
        subtotal += o.price * o.quantity;
      }
      final serviceCharge = subtotal * 0.1; // 10%
      final total = subtotal + serviceCharge;

      final res = ReservationModel(
        id: 'res_${DateTime.now().millisecondsSinceEpoch}',
        customerId: user.id,
        reservationDate: fullDate,
        numberOfGuests: int.tryParse(_guestsCtrl.text) ?? 2,
        status: 'pending',
        specialRequests: _noteCtrl.text,
        orderItems: orderItems,
        subtotal: subtotal,
        serviceCharge: serviceCharge,
        discount: 0,
        total: total,
        paymentStatus: 'unpaid',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final repo = ReservationRepository();
      await repo.createReservation(res);

      // Clear Cart
      CartScreen.clearCart();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đặt bàn thành công!')));
      Navigator.popUntil(context, (route) => route.isFirst); // Back to Home
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin đặt bàn')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text('Chọn ngày'),
              subtitle: Text('${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context, 
                  firstDate: DateTime.now(), 
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                  initialDate: _selectedDate,
                );
                if (d != null) setState(() => _selectedDate = d);
              },
            ),
            ListTile(
              title: const Text('Chọn giờ'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                 final t = await showTimePicker(context: context, initialTime: _selectedTime);
                 if (t != null) setState(() => _selectedTime = t);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _guestsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Số lượng khách', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteCtrl,
              decoration: const InputDecoration(labelText: 'Ghi chú đặc biệt', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text('Tóm tắt đơn hàng:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...CartScreen.cartItems.map((e) => Text('- ${e.item.name} x ${e.quantity}')),
            
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading ? const CircularProgressIndicator() : const Text('XÁC NHẬN ĐẶT BÀN'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
