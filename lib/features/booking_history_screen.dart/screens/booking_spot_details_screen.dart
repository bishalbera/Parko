import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/constants/utils.dart';

class BookingSpotDetailsScreen extends StatefulWidget {
  final String address;
  final String price;
  final String byVehicle;
  final String date;
  const BookingSpotDetailsScreen(
      {super.key,
      required this.address,
      required this.price,
      required this.byVehicle,
      required this.date});

  @override
  State<BookingSpotDetailsScreen> createState() =>
      _BookingSpotDetailsScreenState();
}

class _BookingSpotDetailsScreenState extends State<BookingSpotDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 38.0),
              child: Text(
                "Details about your\nprevious parking spot.",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.address,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "By vehicle: ${widget.byVehicle}",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Date: ${widget.date}",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Price per hour: \$${widget.price}",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
