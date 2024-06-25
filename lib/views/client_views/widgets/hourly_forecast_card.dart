import 'package:flutter/material.dart';
import 'package:my_mcms/constants/colors.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorPalette.backgroundVariance,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(8),
            Icon(
              icon,
              size: 32,
            ),
            verticalSpace(8),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}
