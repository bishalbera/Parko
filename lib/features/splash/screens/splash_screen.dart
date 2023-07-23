import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/features/home/screens/home_screen.dart';
import 'package:parko/features/onboarding/screens/onboarding_screen.dart';

import '../../../common/constants/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Fix the constructor syntax here.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
    var data = firestore
        .collection('users')
        .doc(ownerId)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        userName = snapshot.get('name');
        userEmail = snapshot.get('email');
        userProfile = snapshot.get('profilePicture');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      // Add childCurrent argument here to fix the error.

      splash: Text(
        "Parko",
        style: GoogleFonts.poppins(
          color: Colors.green,
          fontSize: 42,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black12,
      animationDuration: const Duration(seconds: 3),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.theme,
      nextScreen:
          firebaseAuth.currentUser != null ? HomeScreen() : OnBoardingScreen(),
    );
  }
}
