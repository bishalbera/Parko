import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/bottom_navigation_bar.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/parking/screens/parking_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int walletBalance = 0; // Set your balance here

  String walletCoins = "";

  @override
  void initState() {
    super.initState();
    selectedIndex = 2;
    getWalletCoins();
  }

  void getWalletCoins() {
    var data = firestore
        .collection('users')
        .doc(ownerId)
        .get()
        .then((DocumentSnapshot snapshot) {
      walletCoins = snapshot.get('coins');
      walletBalance = int.parse(walletCoins);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context, title: "Wallet"),
      drawer: buildStylishDrawer(context),
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Your Wallet",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 140,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 75, 72, 72).withOpacity(0.4),
                      Colors.white.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Your Balance\n$walletBalance coins",
                    style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "How to get Parko coins?",
                  style: GoogleFonts.poppins(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          moveScreen(context, const ParkingScreen());
                        },
                        child: Text(
                          "By clicking here.",
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          "\tyou can get some parking spots or rent some, by doing so, you will earn certain amount of coins.",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
