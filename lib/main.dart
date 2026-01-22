import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/navbar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkLoginStatus(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return const Navbar();
        },
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF922627),
          primary: const Color(0xFF922627),
        ),
        scaffoldBackgroundColor: const Color(0xFFFBEFEF), // Background color
        textTheme: GoogleFonts.quicksandTextTheme(), // Quicksand Font
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4F1516),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Color(0xFF922627)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF922627), width: 2),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF4F1516),
          indicatorColor: const Color(0xFF8B3A3B), // Subtle highlight color
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return const IconThemeData(color: Colors.white);
          }),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF922627),
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
