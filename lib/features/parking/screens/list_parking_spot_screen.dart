import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/home/screens/home_screen.dart';

class ListParkingSpotScreen extends StatefulWidget {
  final String ownerId;
  final String placeName;
  ListParkingSpotScreen(
      {Key? key, required this.ownerId, required this.placeName})
      : super(key: key);

  @override
  State<ListParkingSpotScreen> createState() => _ListParkingSpotScreenState();
}

class _ListParkingSpotScreenState extends State<ListParkingSpotScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.placeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Parking Spot For Rent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price per hour'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _submitListing,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      throw Exception('Location service is not enabled.');
    }
  }

  Future<void> _submitListing() async {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    double pricePerHour = double.tryParse(_priceController.text.trim()) ?? 0.0;

    if (name.isEmpty || address.isEmpty || pricePerHour <= 0) {
      // Display an error message if any of the fields are empty or invalid
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all the fields.')));
      return;
    }

    // Get the user's current location
    Position userPosition = await _getCurrentLocation();

    // Create a GeoPoint from the user's current location
    GeoPoint geoPoint = GeoPoint(userPosition.latitude, userPosition.longitude);

    // Convert the GeoPoint to GeoHash
    String geoHash = GeoFlutterFire()
        .point(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        .hash;

    // List the parking spot for rent in Firestore
    listParkingSpotForRent(
      widget.ownerId,
      name,
      address,
      pricePerHour,
      geoPoint,
      geoHash,
    );

    int previousCoins = 0;

    firestore
        .collection('users')
        .doc(ownerId)
        .get()
        .then((DocumentSnapshot snapshot) {
      String walletCoins = snapshot.get('coins');
      previousCoins = int.parse(walletCoins);
      previousCoins += 25;

      firestore.collection('users').doc(ownerId).update({
        'coins': previousCoins.toString(),
      }).then((_) {
        // Update the state here if you need to reflect the change in your UI
        setState(() {});
      });
    });

    _nameController.clear();
    _addressController.clear();
    _priceController.clear();
    moveScreen(context, HomeScreen());
  }

  void listParkingSpotForRent(
    String ownerId,
    String name,
    String address,
    double pricePerHour,
    GeoPoint geoPoint,
    String geoHash,
  ) {
    FirebaseFirestore.instance.collection('parking_spots').add({
      'ownerId': ownerId,
      'name': name,
      'geopoint': geoPoint,
      'address': address,
      'pricePerHour': pricePerHour,
      'isAvailable': true,
      'location': {
        'geopoint': geoPoint,
        'geohash': geoHash,
      },
    }).then((value) {
      print('Parking spot listed for rent successfully!');

      selectedIndex = 0;
      setState(() {});
    }).catchError((error) {
      print('Error listing parking spot for rent: $error');
    });
  }
}
