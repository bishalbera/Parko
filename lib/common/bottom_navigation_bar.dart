import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../features/home/screens/home_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/services/screens/services_screen.dart';
import 'constants/utils.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  const MyCustomBottomNavigationBar({super.key});

  @override
  State<MyCustomBottomNavigationBar> createState() =>
      MyCustomBottomNavigationBarState();
}

class MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.apps,
                text: 'Services',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;

                if (_selectedIndex == 0) {
                  moveScreen(context, const HomeScreen());
                } else if (_selectedIndex == 1) {
                  moveScreen(context, const ServicesScreen());
                } else {
                  moveScreen(context, const ProfileScreen());
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
