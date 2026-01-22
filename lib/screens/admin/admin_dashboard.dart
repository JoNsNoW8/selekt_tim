import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background color is inherited from your ThemeData, 
      // but we ensure it's clean here.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAdminButton(
                context,
                icon: Icons.manage_accounts,
                label: 'Upravljanje nalozima',
                onPressed: () {
                  // TODO: Navigacija ka listi radnika
                  print("Navigacija: Upravljanje nalozima");
                },
              ),
              const SizedBox(height: 25),
              _buildAdminButton(
                context,
                icon: Icons.storage,
                label: 'Upravljanje podacima',
                onPressed: () {
                  // TODO: Navigacija ka bazi podataka/importu
                  print("Navigacija: Upravljanje podacima");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF922627), // Your requested accent red
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}