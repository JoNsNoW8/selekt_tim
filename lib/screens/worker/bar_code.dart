import 'package:flutter/material.dart';

class BarCodeScreen extends StatelessWidget {
  const BarCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "Skeniranje Bar-koda",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("Kamera će biti aktivirana ovde"),
          ],
        ),
      ),
    );
  }
}
