import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Prijavi se')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      setState(() => _isLoading = true);
                      try {
                        await authProvider.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        // Success: AuthProvider will notify listeners, and main.dart will switch to Navbar
                        print('Login successful');  // Debug
                      } catch (e) {
                        print('Login error: $e');  // Debug: Check console for details
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Greška pri prijavi: $e')),
                        );
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}