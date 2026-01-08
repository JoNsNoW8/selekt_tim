import 'package:flutter/material.dart';
import 'package:selekt_tim/services/auth_service.dart';

/*Upravlja autentifikacijom korisnika i obaveštava UI o promenama stanja
UI prica sa AuthProvider-om, on onda koristi AuthService za obavljanje stvarnih operacija autentifikacije
kao što su login, logout i provera tokena
AuthProvider koristi ChangeNotifier da obavesti UI o promenama stanja autentifikacije
*/

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;
  String? _role;

  bool get isLoggedIn => _isLoggedIn;
  String? get role => _role;

  Future<void> login(String username, String password) async {
    //poziva AuthService za login kada korisnik pritisne login dugme
    try {
      final data = await _authService.login(username, password);
      _isLoggedIn = true;
      _role = data?['Uloga'];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _role = null;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    //proverava da li postoji validan token pri pokretanju aplikacije
    //znaci proverava da li je korisnik vec ulogovan
    final token = await _authService.getToken();
    if (token != null) {
      _isLoggedIn = true;
      notifyListeners();
    }
  }
}