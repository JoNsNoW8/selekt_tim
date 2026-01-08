import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/worker/bar_code.dart';
import '../screens/worker/profile.dart';
import '../screens/worker/search_by_surname.dart';
import '../screens/worker/search_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    screens = const [
      SearchScreen(),  // Search by ID
      SearchBySurnameScreen(),  // New: Search by surname
      BarCodeScreen(),
      ProfileScreen(),  // New: Profile with login
    ];
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radnik panel'),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              if (auth.isLoggedIn) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    try {
                      await auth.logout();
                      // AuthProvider notifies, main.dart switches to LoginScreen
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Greška pri odjavi: $e')),
                      );
                    }
                  },
                );
              } else {
                // Removed login button here—handled in Profile screen
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
            controller.jumpToPage(currentScreen);
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search ID'),
          NavigationDestination(icon: Icon(Icons.person_search), label: 'Search Surname'),  // New
          NavigationDestination(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),  // New
        ],
      ),
    );
  }
}