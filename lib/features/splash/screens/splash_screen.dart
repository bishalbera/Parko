import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parko/features/home/screens/home_screen.dart';
import 'package:parko/features/onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
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
      nextScreen: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const OnBoardingScreen(),
    );
  }
}
