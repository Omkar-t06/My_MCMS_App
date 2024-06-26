import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/constants/text_style.dart';
import 'package:my_mcms/service/weather/weather_service.dart';
import 'package:my_mcms/utils/message_widget/loader.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';
import 'package:my_mcms/views/client_views/widgets/weather_utils/hourly_forecast_card.dart';
import 'package:my_mcms/views/client_views/widgets/weather_utils/weather_icondata.dart';

class WeatherSlide extends StatefulWidget {
  const WeatherSlide({super.key});

  @override
  State<WeatherSlide> createState() => _WeatherSlideState();
}

class _WeatherSlideState extends State<WeatherSlide> {
  final _weatherService =
      WeatherService(apiKey: "ccd5734b141462c46b171fd63a3f7282");
  late Future<Map<String, dynamic>> _weather;

  @override
  void initState() {
    super.initState();
    _weather = _fetchWeather();
  }

  Future<Map<String, dynamic>> _fetchWeather() async {
    try {
      List<String> pos = await _weatherService.getCurrentLatAndLong();
      return _weatherService.getWeather(pos[0], pos[1]);
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }

  void _refreshWeather() {
    setState(() {
      _weather = _fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _weather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Error fetching weather data"),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("No weather data available"),
          );
        }

        final data = snapshot.data!;
        final weatherList = data['list'] as List;
        final cityName = data['city']['name'];

        return SizedBox(
          child: Card(
            color: ColorPalette.background,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weather in $cityName",
                        style: subTitleTextStyle,
                      ),
                      IconButton(
                        onPressed: _refreshWeather,
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  verticalSpace(5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 120,
                    child: ListView.builder(
                      itemCount:
                          weatherList.length > 5 ? 5 : weatherList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyForecast = weatherList[index + 1];
                        final hourlySky = hourlyForecast['weather'][0]['main'];
                        final hourlySkyIcon =
                            hourlyForecast['weather'][0]['icon'];
                        final hourlyTemp =
                            hourlyForecast['main']['temp'].toString();
                        final time = DateTime.parse(hourlyForecast['dt_txt']);

                        return HourlyForecastCard(
                          time: DateFormat.j().format(time),
                          temperature: hourlyTemp,
                          icon: getWeatherIcon(hourlySky, hourlySkyIcon),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
