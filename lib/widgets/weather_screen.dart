import 'package:flutter/material.dart';
import 'package:selekt_tim/services/weather_api.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherService weatherService = WeatherService();

    return Scaffold(
      appBar: AppBar(title: const Text('Vremenska Prognoza')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: weatherService.fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Greška: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final temp = data['main']['temp'].round();
          final description = data['weather'][0]['description'];
          final humidity = data['main']['humidity'];
          final windSpeed = data['wind']['speed'];
          final icon = data['weather'][0]['icon'];

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.blue.shade300, Colors.blue.shade800],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 30,
                    ),
                    const Text(
                      'Novi Sad',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      'http://openweathermap.org/img/wn/$icon@4x.png',
                      height: 150,
                    ),
                    Text(
                      '$temp°C',
                      style: const TextStyle(
                        fontSize: 64,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      description.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    const Divider(height: 50, color: Colors.white30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _weatherDetail(
                          'Vlažnost',
                          '$humidity%',
                          Icons.water_drop,
                        ),
                        _weatherDetail('Vetar', '$windSpeed m/s', Icons.air),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _weatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
