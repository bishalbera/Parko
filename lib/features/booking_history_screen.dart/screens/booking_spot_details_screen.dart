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
      appBar: makeAppBar(
        context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Text(
                "Details about your\nprevious parking spot.",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Card(
                  elevation: 8,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "${widget.address}",
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "By vehicle: ${widget.byVehicle}",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Date: ${widget.date}",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Price per hour: ${widget.price}",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w500),
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
