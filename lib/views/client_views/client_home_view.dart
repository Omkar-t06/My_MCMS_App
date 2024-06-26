import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';
import 'package:my_mcms/views/client_views/widgets/weather_utils/weather_slides.dart';

class ClientHomeView extends StatelessWidget {
  static const String route = '/client-home';
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customViewAppBar(
        titleText: 'Home Page',
        context: context,
      ),
      body: Column(
        children: [
          const TitleText(
            data: "Welcome to the Muncipal Council Complaint System",
          ),
          verticalSpace(15),
          const SizedBox(height: 200, child: WeatherSlide()),
        ],
      ),
      floatingActionButton: Tooltip(
        message: 'Add new complaint',
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
