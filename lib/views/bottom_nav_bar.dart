import 'package:flutter/material.dart';
import 'package:my_mcms/views/client_views/client_home_view.dart';
import 'package:my_mcms/views/client_views/client_profile_view.dart';
import 'package:my_mcms/views/client_views/complaint_info_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    const ClientHomeView(),
    const ComplaintInfoView(),
    const ClientProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Porfile',
          ),
        ],
        currentIndex: selectedIndex,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
