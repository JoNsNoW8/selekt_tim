import 'package:flutter/material.dart';

class SearchBySurnameScreen extends StatefulWidget {
  const SearchBySurnameScreen({super.key});

  @override
  State<SearchBySurnameScreen> createState() => _SearchBySurnameScreenState();
}

class _SearchBySurnameScreenState extends State<SearchBySurnameScreen> {
  final _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(labelText: 'Prezime vlasnika'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implementirati logiku pretrage po prezimenu
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pretraga za: ${_surnameController.text}')),
                );
              },
              child: const Text('Pretraži'),
            ),
          ],
        ),
      ),
    );
  }
}