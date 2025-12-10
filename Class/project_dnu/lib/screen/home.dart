import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Loại bỏ biểu ngữ debug ở góc trên bên phải
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ứng Dụng Thiết Kế"),
          // Đổi màu nền AppBar
          backgroundColor: Colors.indigo,
          // Thêm một nút hành động bên phải
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Hành động khi nhấn nút Settings
                print("Mở cài đặt");
              },
            ),
          ],
        ),
        // Sử dụng Center để căn giữa nội dung toàn bộ màn hình
        body: Center(
          // Sử dụng Padding để tạo khoảng trống xung quanh nội dung chính
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            // Sử dụng Column để sắp xếp các widget theo chiều dọc
            child: Column(
              // Căn giữa các widget trong Column
              mainAxisAlignment: MainAxisAlignment.center,
              // Tăng kích thước chiều ngang tối thiểu của Column
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: <Widget>[
                // 1. Thêm một Icon lớn
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 80.0,
                ),
                // 2. Thêm khoảng trống
                const SizedBox(height: 20.0), 
                // 3. Tiêu đề chính
                const Text(
                  "Chào Mừng Đến Với Flutter",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                // 4. Thêm khoảng trống
                const SizedBox(height: 10.0), 
                // 5. Nội dung mô tả
                const Text(
                  "Đây là một thiết kế cơ bản sử dụng các Widget phổ biến như Column, Padding, và ElevatedButton.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                // 6. Thêm khoảng trống lớn hơn
                const SizedBox(height: 40.0), 
                // 7. Thêm một nút bấm (Button)
                ElevatedButton(
                  onPressed: () {
                    // Hành động khi nút được nhấn
                    print("Nút đã được nhấn!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan, // Màu nền nút
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    "Bắt Đầu",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}