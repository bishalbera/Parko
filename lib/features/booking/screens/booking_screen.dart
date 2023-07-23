import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/models/parking_spot_for_rent.dart';

class BookingScreen extends StatefulWidget {
  final ParkingSpotForRent parkingSpot;
  const BookingScreen({super.key, required this.parkingSpot});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context, title: "Booking"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Are you sure,\nyou wanna book this parking spot?",
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "${widget.parkingSpot.name}\n${widget.parkingSpot.address}",
                style: GoogleFonts.lato(fontSize: 24, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
