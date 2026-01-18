import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selekt_tim/screens/worker/search_by_surname.dart';
import '../providers/auth_provider.dart';
import '../screens/guest/guest_home_screen.dart';
import '../screens/worker/profile.dart'; // Sadrzi login formu
import '../screens/worker/search_screen.dart';
import '../screens/worker/bar_code.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentScreen = 1; //HOME SCREEN JE DEFAULT
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context); // On slusa promene u auth stanju

    // 1. Ekran za goste
    final List<Widget> guestScreens = [
      const Center(child: Text('Budući API Ekran')), // Levi tba
      const GuestHomeScreen(),                       // Srednji tab
      const ProfileScreen(),                         // Desni tab - login forma
    ];

    // 2. Ekran za radnike
    final List<Widget> workerScreens = [
      const SearchBySurnameScreen(),
      const SearchScreen(),    // Default tab
      const BarCodeScreen(),
      const ProfileScreen(), // Desni tab - profil radnika
    ];

    // Izbor aktivnih ekrana na osnovu auth stanja
    final activeScreens = auth.isLoggedIn ? workerScreens : guestScreens;

    return Scaffold(
      appBar: AppBar(
        title: Text(auth.isLoggedIn ? 'Radnik Panel' : 'SelektTim'),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: activeScreens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
            controller.jumpToPage(index);
          });
        },
        destinations: auth.isLoggedIn 
          ? const [
              NavigationDestination(icon: Icon(Icons.search), label: 'Pretraga vlasnika'),
              NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Pretraga'),
              NavigationDestination(icon: Icon(Icons.qr_code_scanner), label: 'Skeniraj'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
            ]
          : const [
              NavigationDestination(icon: Icon(Icons.info_outline), label: 'Info'),
              NavigationDestination(icon: Icon(Icons.home), label: 'Početna'),
              NavigationDestination(icon: Icon(Icons.login), label: 'Prijava'),
            ],
      ),
    );
  }
}