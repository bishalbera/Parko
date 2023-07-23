import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/auth/screens/log%20in/screens/login_screen.dart';
import 'package:parko/features/onboarding/screens/onboarding_screen.dart';

const String appName = "Parko";
const String appTagline = "Park, where you want! :)";

// firebase vars

var firestore = FirebaseFirestore.instance;
var firebaseAuth = FirebaseAuth.instance;
var ownerId = FirebaseAuth.instance.currentUser?.uid;

File? imageFile;

var locationData;

Widget buildStylishDrawer(BuildContext context) {
  // Define custom green colors
  final Color primaryGreen = Color(0xFF009688);
  final Color secondaryGreen = Color(0xFF00897B);
  final Color headerGreen = Color(0xFF00796B);

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
                    backgroundImage: AssetImage('assets/avatar.jpg'),
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
                // Add navigation logic to your profile screen.
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text(
                "About Us",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add navigation logic to your contact screen.
              },
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

String userName = "";
String userProfile = "";
String userEmail = "";
