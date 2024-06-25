import 'package:flutter/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

IconData getWeatherIcon(String weatherMain, String weatherIcon) {
  switch (weatherMain) {
    case "Clear":
      return weatherIcon.contains('d')
          ? WeatherIcons.day_sunny
          : WeatherIcons.night_clear;
    case "Clouds":
      return WeatherIcons.cloud;
    case "Rain":
      return WeatherIcons.rain;
    case "Thunderstrom":
      return WeatherIcons.thunderstorm;
    case 'Drizzle':
      return WeatherIcons.sprinkle;
    case "Snow":
      return WeatherIcons.snow;
    case 'Mist':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Fog':
    case 'Sand':
    case 'Ash':
    case 'Squall':
    case 'Tornado':
      return WeatherIcons.fog;
    default:
      return WeatherIcons.na;
  }
}
