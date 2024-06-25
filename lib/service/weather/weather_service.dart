import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/forecast";
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Map<String, dynamic>> getWeather(String lat, String lon) async {
    final uri =
        Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric");

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error fetching weather data: ${response.body}');
    } else {
      final data = jsonDecode(response.body);
      return data;
    }
  }

  Future<List<String>> getCurrentLatAndLong() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return ["${position.latitude}", "${position.longitude}"];

    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   position.latitude,
    //   position.longitude,
    // );

    // if (placemarks.isEmpty) {
    //   throw Exception('Could not get location information.');
    // }

    // return placemarks[0].locality ?? '';
  }
}
