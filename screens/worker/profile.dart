import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Prijavite se kao radnik'),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Korisnicko ime'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Lozinka'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Unesite korisnicko ime i lozinku')),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      try {
                        await authProvider.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        // Success: AuthProvider notifies, user stays in navbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Prijava uspešna')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Greška pri prijavi: $e')),
                        );
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: const Text('Prijavi se'),
                  ),
          ],
        ),
      ),
    );
  }
}