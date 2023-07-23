import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parko/common/bottom_navigation_bar.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/features/booking_history_screen.dart/widgets/booking_history_widget.dart';
import 'package:parko/models/booking.dart';

class BookingHistoryScreen extends StatelessWidget {
  final String userUid;

  BookingHistoryScreen({required this.userUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyCustomBottomNavigationBar(),
      drawer: buildStylishDrawer(context),
      appBar: AppBar(
        title: Text('Booking List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('bookerUid', isEqualTo: userUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('No data found'),
            );
          }

          List<BookingModel> bookingModels = snapshot.data!.docs
              .map((doc) => BookingModel(
                    date: doc['date'],
                    address: doc['address'],
                    bookerUid: doc['bookerUid'],
                    bookerName: doc['bookerName'],
                    bookerVehicle: doc['bookerVehicle'],
                    bookerTime: doc['bookerTime'],
                    lat: doc['lat'],
                    long: doc['long'],
                    pricePerHour: doc['pricePerHour'],
                  ))
              .toList();

          // Use GridView.builder instead of ListView.builder
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns in the grid
              crossAxisSpacing: 0, // Set the spacing between columns
              mainAxisSpacing: 0.0, // Set the spacing between rows
            ),
            itemCount: bookingModels.length,
            itemBuilder: (context, index) {
              BookingModel booking = bookingModels[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BookingHistoryWidget(
                  date: booking.date,
                  address: booking.address,
                  price: booking.pricePerHour,
                  vehicle: booking.bookerVehicle,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
