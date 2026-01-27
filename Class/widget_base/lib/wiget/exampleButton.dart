import 'package:flutter/material.dart';

class Examplebutton extends StatelessWidget {
  const Examplebutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "button",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                showMessage(context, "TextXoa du lieu");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: const Color.fromARGB(255, 231, 236, 240),
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(20.0),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text("Xoa du lieu"),
            ),

            // //  Button2
            TextButton.icon(
              onPressed: () {
                showMessage(context, "Text Bao thuc");
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 190, 210, 3),
                foregroundColor: const Color.fromARGB(255, 236, 237, 237),
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(20.0),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              icon: const Icon(Icons.access_alarm),
              label: Text("Bao thuc"),
            ),
            // //  Button3
            TextButton.icon(
              onPressed: () {
                showMessage(context, " Text Update");
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 107, 72, 6),
                foregroundColor: const Color.fromARGB(255, 224, 243, 12),
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(20.0),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              icon: const Icon(Icons.arrow_circle_up_outlined),
              label: Text("Update"),
            ),
            // //  Button4
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Thông báo"),
                      content: const Text("Bạn có chắc chắn không?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // đóng dialog
                          },
                          child: const Text("Hủy"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 249, 13, 205),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(20.0),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.green, width: 3),
                ),
              ),
              icon: const Icon(Icons.no_accounts_outlined),
              label: Text("Thoat"),
            ),
          ],
        ),
      ),
    );
  }
}

void showMessage(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
