import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/bottom_navigation_bar.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/booking_history_screen.dart/screens/booking_history_screen.dart';
import 'package:parko/features/parking/screens/parking_screen.dart';
import 'package:parko/features/services/widgets/service_widget.dart';

import '../../../common/constants/constants.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildStylishDrawer(context),
      appBar: AppBar(
        elevation: 4.0,
        title: const Text('Services'),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: Text(
                    "Park anywhere or\nrent a parking spot.",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ServiceWidget(
                          text: "Mark your place for rent.",
                          imageLocation: "resources/images/car_clipart.png",
                          onTap: () {
                            moveScreen(context, ParkingScreen());
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ServiceWidget(
                          text: "Previous parking spots.",
                          imageLocation: "resources/images/car_clipart.png",
                          onTap: () {
                            moveScreen(context,
                                BookingHistoryScreen(userUid: ownerId!));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
