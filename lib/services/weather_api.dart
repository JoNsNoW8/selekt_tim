import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
<<<<<<< HEAD
  final String apiKey = 'kljuc primer zbog gita';
=======
  final String apiKey = '4b8447d18269bb63a8ab73d4ca6124e4';
>>>>>>> 59c848e319b4e4f0b9a078ba671a25b7ead52877
  final String city = 'Novi Sad'; 

  Future<Map<String, dynamic>> fetchWeather() async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('API Error Body: ${response.body}');
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}