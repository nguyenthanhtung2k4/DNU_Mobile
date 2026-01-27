import 'package:flutter/material.dart';

class InputNameScreen extends StatefulWidget {
  final String currentName; 
  const InputNameScreen({super.key, required this.currentName});

  @override
  State<InputNameScreen> createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller với giá trị cũ nhận được
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nhập tên mới")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Tên hiển thị",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              autofocus: true, // Tự động bật bàn phím
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Lưu thay đổi"),
              onPressed: () {
                // --- TRẢ DỮ LIỆU VỀ ---
                // Navigator.pop(context, [KẾT QUẢ])
                Navigator.pop(context, _controller.text);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String myName = "Tao  la  Tung";

  // Hàm này phải là async vì phải đợi (await)
  void _editName() async {
    // 1. Chờ đợi (await) kết quả từ màn hình Input
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputNameScreen(currentName: myName),
      ),
    );

    // 2. Sau khi màn Input đóng lại, code mới chạy tiếp xuống đây
    print("Kết quả trả về: $result");

    // 3. Kiểm tra xem người dùng có bấm Save (có data) hay bấm Back (null)
    if (result != null) {
      setState(() {
        myName = result; // Cập nhật UI
      });
      // Hiện thông báo nhỏ (SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đã cập nhật tên thành công!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin cá nhân")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            Text("Xin chào,", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text(myName, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _editName, // Gọi hàm async ở trên
              child: const Text("Chỉnh sửa tên"),
            )
          ],
        ),
      ),
    );
  }
}