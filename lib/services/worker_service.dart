//logika koja salje POST zahteve kako bi se kreirali novi radnici
import 'dart:convert';
import 'package:http/http.dart' as http;
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
}
