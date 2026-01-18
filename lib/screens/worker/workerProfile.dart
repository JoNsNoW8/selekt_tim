import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

//test klasa za prikaz profila radnika
class ProfileScreenTest extends StatelessWidget {
  const ProfileScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text("Ime: Marko", style: TextStyle(fontSize: 18)),
            const Text("Prezime: Marković", style: TextStyle(fontSize: 18)),
            const Text("Uloga: Terenski Radnik", 
              style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => auth.logout(),
              icon: const Icon(Icons.logout),
              label: const Text("Odjavi se"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
            ),
          ],
        ),
      ),
    );
  }
}