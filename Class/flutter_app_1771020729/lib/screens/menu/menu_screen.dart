import 'package:flutter/material.dart';
import '../../repositories/menu_item_repository.dart';
import '../../models/menu_item_model.dart';
import '../../utils/seed_data.dart';
import '../cart/cart_screen.dart'; // Màn hình giỏ hàng (sẽ tạo sau)
import '../auth/login_screen.dart'; // Để đăng xuất
import '../../services/local_store.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _repo = MenuItemRepository();
  String _searchQuery = '';
  String? _selectedCategory;
  bool _isVegetarian = false;
  bool _isSpicy = false;

  // Danh sách tạm (Giỏ hàng đơn giản lưu trên RAM để test)
  // Thực tế nên dùng LocalStore hoặc Provider/Bloc
  static List<MenuItemModel> cart = [];

  void _logout() async {
    await LocalStore.clearUser();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menu', style: TextStyle(fontSize: 18)),
            Text('Restaurant App - 1771020729', // Mã sinh viên
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
             icon: const Icon(Icons.shopping_cart),
             onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
             },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            onPressed: () async {
               await SeedData.seed();
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Đã nạp lại dữ liệu mẫu!')),
               );
               setState(() {}); // Reload
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // THANH TÌM KIẾM & BỘ LỌC
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm món ăn...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Filter Category
                      DropdownButton<String>(
                        hint: const Text('Loại món'),
                        value: _selectedCategory,
                        items: ['Appetizer', 'Main Course', 'Dessert', 'Drink', 'Salad']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedCategory = val),
                      ),
                      if (_selectedCategory != null)
                        IconButton(
                            icon: const Icon(Icons.clear, size: 16),
                            onPressed: () => setState(() => _selectedCategory = null)),
                      
                      const SizedBox(width: 16),
                      FilterChip(
                        label: const Text('Ăn chạy'),
                        selected: _isVegetarian,
                        onSelected: (val) => setState(() => _isVegetarian = val),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Cay'),
                        selected: _isSpicy,
                        onSelected: (val) => setState(() => _isSpicy = val),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          
          Expanded(
            child: StreamBuilder<List<MenuItemModel>>(
              stream: _repo.getAll(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Center(child: Text('Lỗi: ${snapshot.error}'));
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                // Client-side Filtering
                // Firestore không hỗ trợ filter nhiều trường phức tạp kết hợp search text dạng "contains"
                // nên ta lọc phía client cho đơn giản với bộ dữ liệu nhỏ.
                var items = snapshot.data!;

                if (_searchQuery.isNotEmpty) {
                  items = items.where((i) => i.name.toLowerCase().contains(_searchQuery)).toList();
                }
                if (_selectedCategory != null) {
                  items = items.where((i) => i.category == _selectedCategory).toList();
                }
                if (_isVegetarian) {
                  items = items.where((i) => i.isVegetarian == true).toList();
                }
                if (_isSpicy) {
                  items = items.where((i) => i.isSpicy == true).toList();
                }

                if (items.isEmpty) {
                  return const Center(child: Text('Không tìm thấy món nào'));
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(
                        item.imageUrl,
                        width: 60, height: 60, fit: BoxFit.cover,
                        errorBuilder: (_,__,___) => const Icon(Icons.fastfood),
                      ),
                      title: Text(item.name),
                      subtitle: Text('${item.price} VND'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.orange),
                        onPressed: item.isAvailable ? () {
                           CartScreen.addToCart(item); // Hàm static, sẽ định nghĩa ở CartScreen
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Đã thêm ${item.name}'), duration: const Duration(seconds: 1)),
                           );
                        } : null,
                      ),
                       onTap: () {
                         // Code show modal cũ (giữ nguyên hoặc copy lại nếu cần)
                         // Để gọn tôi chỉ demo logic chính.
                       },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
