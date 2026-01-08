import 'package:flutter/material.dart';

class BarCodeScreen extends StatefulWidget{
  const BarCodeScreen({super.key});

  @override
  State<BarCodeScreen> createState() => _BarCodeScreenState();
}
class _BarCodeScreenState extends State<BarCodeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: const Text('Bar kod skener'),
        ),
      );
  }
}