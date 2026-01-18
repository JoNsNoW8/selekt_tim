import 'package:flutter/material.dart';

class SearchBySurnameScreen extends StatelessWidget {
  const SearchBySurnameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Pretraga po Vlasniku", 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Unesite prezime vlasnika...",
                prefixIcon: const Icon(Icons.person_search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Expanded(child: Center(child: Text("Lista vlasnika će biti ovde"))),
          ],
        ),
      ),
    );
  }
}