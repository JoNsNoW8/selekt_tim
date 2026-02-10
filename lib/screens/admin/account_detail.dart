import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selekt_tim/providers/auth_provider.dart';
import 'package:selekt_tim/services/worker_service.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late TextEditingController _imeController;
  late TextEditingController _prezimeController;
  late TextEditingController _userController;
  late TextEditingController _passController;
  String _selectedRole = 'worker';

  @override
  void initState() {
    super.initState();
    _imeController = TextEditingController(text: widget.user['ime']);
    _prezimeController = TextEditingController(text: widget.user['prezime']);
    _userController = TextEditingController(text: widget.user['username']);
    _passController = TextEditingController();
    _selectedRole = widget.user['uloga'] ?? 'worker';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil: ${_userController.text}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _imeController,
              decoration: const InputDecoration(labelText: 'Ime'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _prezimeController,
              decoration: const InputDecoration(labelText: 'Prezime'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Korisničko ime'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(
                labelText: 'Nova Lozinka (ostavi prazno ako ne menjaš)',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => _updateUser(),
              child: const Text('Sačuvaj izmene'),
            ),
            TextButton(
              onPressed: () => _confirmDelete(),
              child: const Text(
                'Obriši ovaj nalog',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUser() async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final success = await UserService().updateUser(
        userId: widget.user['id'],
        data: {
          'ime': _imeController.text,
          'prezime': _prezimeController.text,
          'username': _userController.text,
          'uloga': _selectedRole,
          'password': _passController.text.isEmpty
              ? null
              : _passController.text,
        },
      );

      if (success && mounted) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        if (widget.user['username'] == authProvider.userData?['username']) {
    authProvider.updateLocalUserData({
          'ime': _imeController.text,
          'prezime': _prezimeController.text,
          'username': _userController.text,
          'uloga': _selectedRole,
          'password': _passController.text.isEmpty
              ? null
              : _passController.text,
        },);
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Uspešno ažurirano!'), backgroundColor: Colors.green),
  );
  Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Greška pri čuvanju.'),
            backgroundColor: Colors.red,
          ),
        );
      }

      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Uspešno sačuvano!')));
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Greška: $e')));
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Brisanje naloga'),
        content: Text(
          'Da li ste sigurni da želite da obrišete korisnika ${_userController.text}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Otkaži'),
          ),
          TextButton(
            onPressed: () async {
              await UserService().deleteUser(widget.user['id']);
              Navigator.pop(context);
              Navigator.pop(context); 
            },
            child: const Text('OBRIŠI', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
