import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selekt_tim/screens/auth/register_screen.dart';
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
    // AuthProvider odlucuje koji UI da prikaze
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(authProvider.isLoggedIn ? 'Vaš Profil' : 'Prijava'),
        centerTitle: true,
      ),
      body: authProvider.isLoggedIn
          ? _buildWorkerProfile(
              authProvider,
            ) // ako je prijavljen, prikazi profil
          : _buildLoginForm(authProvider), // ako nije, pokazi login formu
    );
  }

  // --- UI ako je  PRIJAVLJEN ---
  Widget _buildWorkerProfile(AuthProvider auth) {
    final String ime = auth.userData?['ImeRadnika'] ?? "Korisnik";
    final String prezime = auth.userData?['PrezimeRadnika'] ?? "";
    final String uloga = auth.userRole == 'admin'
        ? "Administrator"
        : "Terenski Radnik";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: auth.userRole == 'admin'
                ? Colors.orange
                : Colors.blue,
            child: const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            "$ime $prezime",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              uloga,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => auth.logout(),
            icon: const Icon(Icons.logout),
            label: const Text("Odjavi se"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red,
              minimumSize: const Size(200, 50),
            ),
          ),
        ],
      ),
    );
  }

  // --- UI za GOSTE (Login forma) ---
  Widget _buildLoginForm(AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Prijavite se kao radnik', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
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
          const SizedBox(height: 25),
          _isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Unesite podatke')),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      try {
                        await authProvider.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Greška: $e')));
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: const Text('Prijavi se'),
                  ),
                ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
            child: const Text('Nemate nalog? Registrujte se ovde'),
          ),
        ],
      ),
    );
  }
}
