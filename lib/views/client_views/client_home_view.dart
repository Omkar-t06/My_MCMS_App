import 'package:flutter/material.dart';
import 'package:my_mcms/utils/widgets/custom_appbar.dart';
import 'package:my_mcms/utils/widgets/custom_drawer.dart';
import 'package:my_mcms/utils/widgets/title_text.dart';
import 'package:my_mcms/utils/widgets/vertical_space.dart';

class ClientHomeView extends StatelessWidget {
  static const String route = '/client-home';
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customAppBar(
        titleText: 'Home Page',
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              const TitleText(
                data: "Welcome to the Muncipal Council Complaint System",
              ),
              verticalSpace(15),
              // SizedBox(
              //   height: height * 0.25,
              //   child: const WeatherSlide(),
              // ),
              verticalSpace(15),
              // SizedBox(
              //   height: height * 0.82,
              //   child: const NewsSection(),
              // ),
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
