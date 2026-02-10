//logika koja salje POST zahteve kako bi se kreirali novi radnici
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:selekt_tim/services/auth_service.dart';
import '../config/api_config.dart';

class UserService {
  Future<bool> registerWorker({
    required String username,
    required String password,
    required String ime,
    required String prezime,
    required String inviteCode,
  }) async {
    final response = await http.post(
      Uri.parse('${APiConfig.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'ime': ime,
        'prezime': prezime,
        'invite_code': inviteCode,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['detail'] ?? 'Greška pri registraciji');
    }
  }

  Future<List<dynamic>> getAllUsers() async {
    final auth = AuthService();
    final token = await auth.getToken();

    final response = await http.get(
      Uri.parse('${APiConfig.baseUrl}/auth/users'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Neuspešno učitavanje radnika');
    }
  }

  // Delete user
  Future<void> deleteUser(int userId) async {
    final auth = AuthService();
    final token = await auth.getToken();

    await http.delete(
      Uri.parse('${APiConfig.baseUrl}/auth/users/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<bool> updateUser({
    required int userId,
    required Map<String, dynamic> data,
  }) async {
    final auth = AuthService();
    final token = await auth.getToken();

    final Map<String, dynamic> requestBody = {
      'ime': data['ime'],
      'prezime': data['prezime'],
      'username': data['username'],
      'uloga': data['uloga'],
    };

    if (data['password'] != null && data['password'].toString().isNotEmpty) {
      requestBody['password'] = data['password'];
    }

    final response = await http.put(
      Uri.parse('${APiConfig.baseUrl}/auth/users/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode != 200) {
      print("Backend Error: ${response.body}"); //debug
    }

    return response.statusCode == 200;
  }
}
