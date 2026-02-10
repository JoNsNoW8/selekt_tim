import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selekt_tim/screens/admin/admin_dashboard.dart';
import 'package:selekt_tim/screens/worker/search_by_surname.dart';
import 'package:selekt_tim/widgets/weather_screen.dart';
import '../providers/auth_provider.dart';
import '../screens/guest/guest_home_screen.dart';
import '../screens/worker/profile.dart';
import '../screens/worker/search_screen.dart';
import '../screens/worker/bar_code.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentScreen = 1;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  List<Widget> _getScreens(AuthProvider auth) {
    if (!auth.isLoggedIn) {
      return [
        const WeatherScreen(),
        const GuestHomeScreen(),
        const ProfileScreen(), //Login tab
      ];
    } else if (auth.userRole == 'admin') {
      return [
        const AdminPanel(), //Upravljanje nalozima
        const SearchBySurnameScreen(),
        const SearchScreen(),
        const BarCodeScreen(),
        const ProfileScreen(), //Profil tab
      ];
    } else {
      return [
        const SearchBySurnameScreen(),
        const SearchScreen(),
        const BarCodeScreen(),
        const ProfileScreen(),
      ];
    }
  }

  List<NavigationDestination> _getDestinations(AuthProvider auth) {
    if (!auth.isLoggedIn) {
      return const [
        NavigationDestination(icon: Icon(Icons.info_outline), label: 'Info'),
        NavigationDestination(icon: Icon(Icons.home), label: 'Početna'),
        NavigationDestination(icon: Icon(Icons.login), label: 'Prijava'),
      ];
    } else if (auth.userRole == 'admin') {
      return const [
        NavigationDestination(
          icon: Icon(Icons.admin_panel_settings),
          label: 'Admin',
        ),
        NavigationDestination(icon: Icon(Icons.people), label: 'Vlasnik'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Pretraga ID'),
        NavigationDestination(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Skeniraj',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
      ];
    } else {
      return const [
        NavigationDestination(icon: Icon(Icons.people), label: 'Vlasnik'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Pretraga ID'),
        NavigationDestination(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Skeniraj',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final activeScreens = _getScreens(auth);
    final destinations = _getDestinations(auth);

    if (currentScreen >= activeScreens.length) {
      currentScreen = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          auth.isLoggedIn
              ? (auth.userRole == 'admin' ? 'Admin Panel' : 'Radnik Panel')
              : 'SelektTim',
        ),
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
        destinations: destinations,
      ),
    );
  }
}
