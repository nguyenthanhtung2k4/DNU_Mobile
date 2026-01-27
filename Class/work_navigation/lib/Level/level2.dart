import 'package:flutter/material.dart';

class Level2 extends StatelessWidget {
  // 1. Khai báo các biến sẽ nhận
  final String tenSanPham;
  final int gia;
  final String moTa;

  // 2. Constructor buộc phải có tham số (required)
  const Level2({
    super.key, 
    required this.tenSanPham, 
    required this.gia,
    this.moTa = "Sản phẩm chính hãng chất lượng cao.", // Giá trị mặc định
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tenSanPham)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container( // Giả lập ảnh sản phẩm
              height: 200, width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.shopping_bag, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            Text(tenSanPham, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("$gia VND", style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.w600)),
            const Divider(height: 30),
            Text("Mô tả: $moTa", style: const TextStyle(fontSize: 16)),
            
            const Spacer(), // Đẩy nút xuống đáy
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15), backgroundColor: Colors.blue),
                child: const Text("Quay lại", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}




class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data giả
    final products = ["iPhone 15", "Samsung S24", "Xiaomi 14"];
    final prices = [20000000, 18000000, 12000000];

    return Scaffold(
      appBar: AppBar(title: const Text("Cửa hàng điện thoại")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.phone_android)),
              title: Text(products[index], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${prices[index]} VND"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // --- CHUYỂN MÀN HÌNH KÈM DỮ LIỆU ---
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Gọi Constructor và truyền tham số vào
                    builder: (context) => Level2(
                      tenSanPham: products[index],
                      gia: prices[index],
                      // moTa: có thể bỏ qua vì đã có mặc định
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}