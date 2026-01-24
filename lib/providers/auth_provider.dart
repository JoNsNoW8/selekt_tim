import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selekt_tim/services/auth_service.dart';

/*Upravlja autentifikacijom korisnika i obaveštava UI o promenama stanja
UI prica sa AuthProvider-om, on onda koristi AuthService za obavljanje stvarnih operacija autentifikacije
kao što su login, logout i provera tokena
AuthProvider koristi ChangeNotifier da obavesti UI o promenama stanja autentifikacije
*/

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final String baseUrl = 'http://192.168.0.17:8000';
  bool _isLoggedIn = false;
  String? _userRole;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  String? get userRole => _userRole;
  Map<String, dynamic>? get userData => _userData;

  Future<void> login(String username, String password) async {
    //poziva AuthService za login kada korisnik pritisne login dugme
    try {
      final data = await _authService.login(username, password);
      _isLoggedIn = true;
      _userRole = data?['Uloga'];
      _userData = data;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(
    String ime,
    String prezime,
    String username,
    String password,
    String inviteCode,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ime': ime,
          'prezime': prezime,
          'username': username,
          'password': password,
          'invite_code': inviteCode,
        }),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        final errorData = jsonDecode(response.body);
        throw errorData['detail'] ?? 'Greška pri registraciji';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _userRole = null;
    _userData = null;
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
