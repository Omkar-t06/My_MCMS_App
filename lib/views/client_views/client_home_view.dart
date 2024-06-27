import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';
import 'package:my_mcms/views/client_views/widgets/news_utils/news_section.dart';
import 'package:my_mcms/views/client_views/widgets/weather_utils/weather_slides.dart';

class ClientHomeView extends StatelessWidget {
  static const String route = '/client-home';
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customViewAppBar(
        titleText: 'Home Page',
        context: context,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              const TitleText(
                data: "Welcome to the Muncipal Council Complaint System",
              ),
              verticalSpace(15),
              SizedBox(
                height: height * 0.25,
                child: const WeatherSlide(),
              ),
              verticalSpace(15),
              SizedBox(
                height: height * 0.9,
                child: const NewsSection(),
              ),
            ],
          ),
        ),
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
