import 'package:flutter/material.dart';
import '../../models/customer_model.dart';
import '../../repositories/customer_repository.dart';
import '../../services/local_store.dart';
import '../menu/menu_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  
  final List<String> _allPreferences = ['Thích cay', 'Ăn chay', 'Không hành', 'Thích ngọt', 'Ít đường'];
  final List<String> _selectedPreferences = [];
  
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final id = 'cus_${DateTime.now().millisecondsSinceEpoch}';
      final newCustomer = CustomerModel(
        id: id,
        fullName: _fullNameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phoneNumber: _phoneCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
        preferences: _selectedPreferences,
        loyaltyPoints: 0,
        createdAt: DateTime.now(),
        isActive: true,
      );

      final repo = CustomerRepository();
      // Check exist
      final exist = await repo.checkLogin(newCustomer.phoneNumber);
      if (exist != null) {
         if (!mounted) return;
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Số điện thoại đã tồn tại!')),
        );
        setState(() => _isLoading = false);
        return;
      }

      await repo.addCustomer(newCustomer);
      await LocalStore.saveUser(newCustomer);

      if (!mounted) return;
      // Go to Menu (Remove all previous routes)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MenuScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameCtrl,
                decoration: const InputDecoration(labelText: 'Họ và tên'),
                validator: (v) => v!.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
                validator: (v) => v!.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Sở thích ăn uống:', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Wrap(
                spacing: 8,
                children: _allPreferences.map((pref) {
                  final isSelected = _selectedPreferences.contains(pref);
                  return FilterChip(
                    label: Text(pref),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedPreferences.add(pref);
                        } else {
                          _selectedPreferences.remove(pref);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('ĐĂNG KÝ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
