import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selekt_tim/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _imeController = TextEditingController();
  final _prezimeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registracija Radnika')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.person_add, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            TextField(
              controller: _imeController,
              decoration: const InputDecoration(
                labelText: 'Ime',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _prezimeController,
              decoration: const InputDecoration(
                labelText: 'Prezime',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Korisničko ime',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Lozinka',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _inviteCodeController,
              decoration: const InputDecoration(
                labelText: 'Pozivni kod',
                hintText: 'Unesite kod koji ste dobili od CEO-a',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isRegistering
                    ? null
                    : () async {
                        if (_usernameController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _inviteCodeController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sva polja su obavezna!'),
                            ),
                          );
                          return;
                        }

                        setState(() => _isRegistering = true);
                        try {
                          await Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).register(
                            _imeController.text,
                            _prezimeController.text,
                            _usernameController.text,
                            _passwordController.text,
                            _inviteCodeController.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Uspešna registracija! Prijavite se.',
                              ),
                            ),
                          );
                          Navigator.pop(context); // Go back to Login
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Greška: $e')));
                        } finally {
                          setState(() => _isRegistering = false);
                        }
                      },
                child: _isRegistering
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Registruj se'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
