import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

class AuthService {
  Future<Map<String, dynamic>?> login(String username, String password) async { 
    //metoda kada korisnik pritisne login dugme
    //saljemo POST zahtev na login endpoint sa korisnickim imenom i lozinkom
    final response = await http.post(  
      Uri.parse(APiConfig.loginEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) { //ako je odgovor uspešan
      final data  = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance(); //cuvamo token i ulogu u shared preferences
      prefs.setString('token', data['access_token']);
      prefs.setString('uloga', data['Uloga']);
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<String?> getToken() async { //metoda za dobijanje tokena iz shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async { //metoda za logout, brisemo token i ulogu iz shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('uloga');
  } 
}