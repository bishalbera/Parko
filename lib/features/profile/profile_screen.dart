import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parko/common/bottom_navigation_bar.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/about_parko/screens/about_screen.dart';
import 'package:parko/features/booking_history_screen.dart/screens/booking_history_screen.dart';
import 'package:parko/features/parking/screens/parking_screen.dart';
import 'package:parko/features/profile/profile_widget.dart';
import 'package:parko/features/wallet/screens/wallet_screen.dart';

import '../about_app/about_app_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    var data = firestore.collection("users").doc(ownerId).get().then((
      DocumentSnapshot snapshot,
    ) {
      userName = snapshot.get('name');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    // Format the date as "23rd July, 2023"
    String formattedDate = DateFormat('dd MMMM, yyyy').format(currentDate);

    return Scaffold(
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
      drawer: buildStylishDrawer(context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 15),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$userName",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${formattedDate}",
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 130,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://d112y698adiu2z.cloudfront.net/photos/production/challenge_thumbnails/002/491/831/datas/original.png'),
                      radius: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: ProfileWidget(icon: Icon(Icons.help), text: 'Help'),
                    onTap: () {
                      moveScreen(context, AppFeaturesScreen());
                    },
                  ),
                  InkWell(
                    onTap: () {
                      moveScreen(
                          context,
                          BookingHistoryScreen(
                            userUid: ownerId!,
                          ));
                    },
                    child: const ProfileWidget(
                        icon: Icon(Icons.trip_origin_sharp),
                        text: 'Parking\nhistory.'),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 10,
                color: Color.fromARGB(255, 229, 226, 226),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  moveScreen(context, AboutScreen());
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About Parko"),
                ),
              ),
              InkWell(
                onTap: () {
                  moveScreen(context, ParkingScreen());
                },
                child: const ListTile(
                  leading: Icon(Icons.local_parking),
                  title: Text("Locate a parking spot"),
                ),
              ),
              InkWell(
                onTap: () {
                  moveScreen(context, const ParkingScreen());
                },
                child: const ListTile(
                  leading: Icon(Icons.car_rental_rounded),
                  title: Text("Give your spot for rent for parking"),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  moveScreen(context, const WalletScreen());
                },
                child: const ListTile(
                  leading: Icon(Icons.wallet),
                  title: Text("Your Wallet"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
