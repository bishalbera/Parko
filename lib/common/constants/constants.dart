import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/about_parko/screens/about_screen.dart';
import 'package:parko/features/auth/screens/log%20in/screens/login_screen.dart';
import 'package:parko/features/booking_history_screen.dart/screens/booking_history_screen.dart';
import 'package:parko/features/home/screens/home_screen.dart';
import 'package:parko/features/parking/screens/parking_screen.dart';
import 'package:parko/features/profile/profile_screen.dart';
import 'package:parko/features/wallet/screens/wallet_screen.dart';

const String appName = "Parko";
const String appTagline = "Park, where you can or rent it! :)";

// firebase vars

var firestore = FirebaseFirestore.instance;
var firebaseAuth = FirebaseAuth.instance;
var ownerId = FirebaseAuth.instance.currentUser?.uid;

File? imageFile;

var locationData;

Widget buildStylishDrawer(BuildContext context) {
  // Define custom green colors
  final Color primaryGreen = Color.fromARGB(255, 170, 198, 241);
  final Color secondaryGreen = Color.fromARGB(255, 129, 115, 207);
  final Color headerGreen = Color.fromARGB(255, 74, 68, 248);

  return Drawer(
    child: Stack(
      children: <Widget>[
        // Background with gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryGreen, secondaryGreen],
            ),
          ),
        ),

        // List view for drawer items
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Custom header for the drawer
            Container(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              decoration: BoxDecoration(
                color: headerGreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://d112y698adiu2z.cloudfront.net/photos/production/challenge_thumbnails/002/491/831/datas/original.png'),
                    radius: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${userName}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${userEmail}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer items
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, HomeScreen());
                // Add navigation logic to your home screen.
              },
            ),

            ListTile(
              leading: Icon(Icons.route, color: Colors.white),
              title: Text(
                "Get best route",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, HomeScreen());
                // Add navigation logic to your profile screen.
              },
            ),

            ListTile(
              leading: Icon(Icons.park, color: Colors.white),
              title: Text(
                "Find spots to park",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, ParkingScreen());
                // Add navigation logic to your profile screen.
              },
            ),

            ListTile(
              leading: Icon(Icons.history, color: Colors.white),
              title: Text(
                "Parking Spots History",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, BookingHistoryScreen(userUid: ownerId!));
                // Add navigation logic to your profile screen.
              },
            ),
            ListTile(
              leading: Icon(Icons.wallet, color: Colors.white),
              title: Text(
                "Wallet",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, WalletScreen());
                // Add navigation logic to your profile screen.
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                moveScreen(context, ProfileScreen());
                // Add navigation logic to your profile screen.
              },
            ),
            InkWell(
              onTap: () {
                moveScreen(context, AboutScreen());
              },
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text(
                  "About App",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  moveScreen(context, AboutScreen());
                  // Add navigation logic to your contact screen.
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add navigation logic to your settings screen.
              },
            ),
            // Add more list items as needed for your app.

            // A divider to separate items
            Divider(color: Colors.white),

            // Logout button
            InkWell(
              onTap: () {
                firebaseAuth.signOut();
                moveScreen(context, LoginScreen());
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implement your logout logic.
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

String aboutTheApp =
    "Develop an intelligent parking management system called 'Parko' that leverages technology to optimize parking availability and enhance the overall parking experience.";

String workingOfTheApp =
    "Please open the app, you can register here with your profile picture, name, email and password, once that is done, you can go to the home screen where you can search for various locations (routes), it will give you the best and the most efficient route to your destination. You can also rent a parking spot or list your parking spot for rent. You can also view your booking history and your profile, you also have an option to get gift cards and earn points.";

String userName = "";
String userProfile = "";
String userEmail = "";
