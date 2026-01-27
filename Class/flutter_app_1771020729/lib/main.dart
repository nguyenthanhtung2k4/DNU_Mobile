import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/menu/menu_screen.dart';
import 'services/firestore_service.dart';
import 'screens/auth/login_screen.dart';
import 'services/local_store.dart';

void main() async {
  // Bắt buộc phải có dòng này khi dùng Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const AuthCheck(), // Class kiểm tra đăng nhập
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    final user = await LocalStore.getUser();
    if (!mounted) return;
    
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MenuScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

void testFirestore() {
  final service = FirestoreService.instance;
  print(service.customersRef.path); // customers
  print(service.menuItemsRef.path); // menu_items
  print(service.reservationsRef.path); // reservations
}
