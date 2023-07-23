import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/auth/screens/log%20in/widgets/custom_text_field.dart';
import 'package:parko/features/models/parking_spot_for_rent.dart';

class BookingScreen extends StatefulWidget {
  final ParkingSpotForRent parkingSpot;
  const BookingScreen({super.key, required this.parkingSpot});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _timeController.dispose();
    _vehicleController.dispose();
  }

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
                "Please fill some additional details\nin order to book this spot.",
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${widget.parkingSpot.name}\n${widget.parkingSpot.address}",
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    label: 'Enter your name.', controller: _nameController),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    label: 'In how much mins, will you arrive?',
                    controller: _timeController),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    label: 'What is your vehicle(i.e car?)',
                    controller: _vehicleController),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Changed your mind?",
              style: GoogleFonts.roboto(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 60),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(22),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Book",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
