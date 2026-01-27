# 1. Clone cha  và con
```bash
git clone --recurse-submodules <URL_kho_cha>

git clone <URL_kho_cha> (Clone kho cha)

git submodule update --init --recursive (Tải submodule)
```

## documnets  flutter
- dev.fluter
- dart.dev
- pub.dev

## Project Flutter
- Trước khi dùng Flutter cần cài :
  - Link cài :  
### Check  version 
```bash
flutter  --version
#  Nếu có thì  version  thì cài thành công!
flutter  doctor 
# all  câu lệnh flutter
```

```bash
flutter create  {name} # Tạo  Project

flutter run # chạy  dự án flutter

```"# AnTam-Flutter-Php" 
```
# 2.  Các phím gõ tắt
```bash 
stl -> ( Stateless wiget)
stf -> ( Statefull ưidget)

```
# Các trường hợp
## RUN APP 
-  Dùng để chạy dự án trong Flutter ->  Như hàm main() 
  
   - Khi ta chuyền thằng trực tiếp từ khởi tạo chuyền vào luôn RunApp nó sẽ lỗi ( No Diratial ) 
   - Đặt `` MaterialApp()`` -> là root widget (  nó là địng nghĩa của Fluter)


## Tổ chức cấu trúc main




Dưới đây là **README đầy đủ về `Scaffold` trong Flutter**, viết bằng **tiếng Việt**, có **ví dụ hoàn chỉnh + giải thích chi tiết từng thuộc tính**, đúng phong cách tài liệu học tập 📘
(Bạn có thể copy dùng làm README.md)

---

# 3. 📘 Scaffold trong Flutter – Hướng dẫn đầy đủ

## 1️⃣ Scaffold là gì?

`Scaffold` là **khung giao diện chính** cho mỗi màn hình trong Flutter theo Material Design.

👉 Nó cung cấp sẵn các khu vực:

* AppBar
* Body
* Drawer
* BottomNavigationBar
* FloatingActionButton
* SnackBar
* v.v.

📌 **Mỗi màn hình thường dùng 1 Scaffold**

---

## 2️⃣ Cấu trúc tổng quát của Scaffold

```dart
Scaffold(
  appBar: AppBar(),
  body: Widget,
  drawer: Drawer(),
  endDrawer: Drawer(),
  bottomNavigationBar: Widget,
  floatingActionButton: FloatingActionButton(),
  floatingActionButtonLocation: FloatingActionButtonLocation,
  backgroundColor: Color,
)
```

---

## 3️⃣ Ví dụ Scaffold đầy đủ (Hoàn chỉnh)

```dart
import 'package:flutter/material.dart';

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar
      appBar: AppBar(
        title: const Text('Scaffold Example'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      // 2. Drawer (Menu trái)
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),

      // 3. Body (Nội dung chính)
      body: const Center(
        child: Text(
          'Hello Scaffold',
          style: TextStyle(fontSize: 22),
        ),
      ),

      // 4. Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB pressed');
        },
        child: const Icon(Icons.add),
      ),

      // 5. Vị trí của FAB
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,

      // 6. Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

      // 7. Màu nền
      backgroundColor: Colors.white,
    );
  }
}
```

---

## 4️⃣ Giải thích từng thuộc tính của Scaffold

---

### 🔹 1. `appBar`

👉 Thanh tiêu đề trên cùng

```dart
appBar: AppBar(
  title: Text('Title'),
)
```

📌 Thường dùng cho:

* Tiêu đề
* Icon menu
* Search
* Action buttons

---

### 🔹 2. `body`

👉 Nội dung chính của màn hình

```dart
body: Center(
  child: Text('Hello'),
)
```

📌 Có thể chứa:

* Column
* ListView
* GridView
* Form
* Custom Widget

---

### 🔹 3. `drawer`

👉 Menu trượt từ **bên trái**

```dart
drawer: Drawer(
  child: ListView(...)
)
```

📌 Dùng cho:

* Menu
* Điều hướng
* Profile

---

### 🔹 4. `endDrawer`

👉 Menu trượt từ **bên phải**

```dart
endDrawer: Drawer(...)
```

---

### 🔹 5. `floatingActionButton`

👉 Nút hành động nổi (FAB)

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)
```

📌 Thường dùng cho:

* Thêm mới
* Tạo dữ liệu
* Action chính

---

### 🔹 6. `floatingActionButtonLocation`

👉 Vị trí của FAB

```dart
FloatingActionButtonLocation.centerFloat
FloatingActionButtonLocation.endDocked
FloatingActionButtonLocation.centerDocked
```

---

### 🔹 7. `bottomNavigationBar`

👉 Thanh điều hướng dưới

```dart
bottomNavigationBar: BottomNavigationBar(
  items: [...]
)
```

📌 Dùng cho:

* App nhiều tab
* Điều hướng chính

---

### 🔹 8. `backgroundColor`

👉 Màu nền Scaffold

```dart
backgroundColor: Colors.grey[200],
```

---

## 5️⃣ Sơ đồ cấu trúc Scaffold

```
MaterialApp
 └── Scaffold
      ├── AppBar
      ├── Drawer
      ├── Body
      ├── FloatingActionButton
      └── BottomNavigationBar
```

---

## 6️⃣ Lưu ý quan trọng ⚠️

❌ Sai:

```dart
Material(
  child: Text('Hello'),
);
```

✅ Đúng:

```dart
Scaffold(
  body: Text('Hello'),
);
```

📌 `MaterialApp` → `Scaffold` → UI

---

## 7️⃣ Kết luận

✔ `Scaffold` là **trái tim của UI Flutter**
✔ Mỗi màn hình nên có **1 Scaffold**
✔ Kết hợp với `MaterialApp` để app hoạt động đúng chuẩn


