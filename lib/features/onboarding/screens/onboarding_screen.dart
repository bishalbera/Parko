import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/constants/common/custom_continue_button.dart';
import 'package:parko/features/auth/screens/log%20in/screens/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage('resources/images/car_clipart.png'),
              ),
              Center(
                child: Text(
                  'Welcome to\nParko!',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Center(
                  child: Text(
                    'Making rides faster and even more secure!, you are at the correct place! ;)',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomContinueButton(
                onTap: () {
                  moveScreen(context, const LoginScreen());
                },
                text: 'Continue',
                color: HexColor('#999b9e'),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
