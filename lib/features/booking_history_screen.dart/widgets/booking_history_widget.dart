import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/booking_history_screen.dart/screens/booking_spot_details_screen.dart';

class BookingHistoryWidget extends StatefulWidget {
  final String address;
  final String vehicle;
  final String price;
  final String date;

  const BookingHistoryWidget({
    Key? key,
    required this.address,
    required this.price,
    required this.vehicle,
    required this.date,
  }) : super(key: key);

  @override
  State<BookingHistoryWidget> createState() => _BookingHistoryWidgetState();
}

class _BookingHistoryWidgetState extends State<BookingHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(left: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("To: ${widget.address}"),
            Text("By: ${widget.vehicle}"),
            Text("On: ${widget.date}"),
            const SizedBox(height: 8),
            Text("\$ ${widget.price}"),
            const SizedBox(height: 8),
            Center(
              child: InkWell(
                onTap: () {
                  moveScreen(
                      context,
                      BookingSpotDetailsScreen(
                          address: widget.address,
                          price: widget.price,
                          byVehicle: widget.vehicle,
                          date: widget.date));
                },
                child: Container(
                  height: 32,
                  width: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "View Details",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
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
