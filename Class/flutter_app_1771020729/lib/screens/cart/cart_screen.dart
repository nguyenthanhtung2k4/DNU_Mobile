import 'package:flutter/material.dart';
import '../../models/menu_item_model.dart';
import 'reservation_screen.dart'; // Màn hình đặt bàn

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  // Giỏ hàng tĩnh (đơn giản hoá cho bài thi)
  static final List<CartItem> cartItems = [];

  static void addToCart(MenuItemModel item) {
    // Check if exist
    final index = cartItems.indexWhere((e) => e.item.id == item.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(item: item, quantity: 1));
    }
  }

  static void clearCart() {
    cartItems.clear();
  }

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class CartItem {
  final MenuItemModel item;
  int quantity;
  CartItem({required this.item, required this.quantity});
}

class _CartScreenState extends State<CartScreen> {
  
  double get totalPayload {
    return CartScreen.cartItems.fold(0, (sum, e) => sum + (e.item.price * e.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng của bạn')),
      body: Column(
        children: [
          Expanded(
            child: CartScreen.cartItems.isEmpty 
              ? const Center(child: Text('Giỏ hàng trống'))
              : ListView.builder(
                  itemCount: CartScreen.cartItems.length,
                  itemBuilder: (context, index) {
                    final cItem = CartScreen.cartItems[index];
                    return ListTile(
                      title: Text(cItem.item.name),
                      subtitle: Text('${cItem.item.price} x ${cItem.quantity} = ${cItem.item.price * cItem.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (cItem.quantity > 1) {
                                  cItem.quantity--;
                                } else {
                                  CartScreen.cartItems.removeAt(index);
                                }
                              });
                            },
                          ),
                          Text('${cItem.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                               setState(() => cItem.quantity++);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.orange[50],
            child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    const Text('Tạm tính:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('$totalPayload VND', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                   ],
                 ),
                 const SizedBox(height: 16),
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                     onPressed: CartScreen.cartItems.isEmpty ? null : () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReservationScreen()));
                     },
                     child: const Text('TIẾP TỤC ĐẶT BÀN'),
                   ),
                 )
               ],
            ),
          )
        ],
      ),
    );
  }
}
