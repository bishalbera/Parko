import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parko/common/constants/constants.dart';

class ListParkingSpotScreen extends StatefulWidget {
  final String ownerId;
  final String placeName;
  ListParkingSpotScreen(
      {super.key, required this.ownerId, required this.placeName});

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
    _addressController.text = locationData;
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
            SizedBox(
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

  // Function to list a parking spot for rent
  void listParkingSpotForRent(
      String ownerId, String name, String address, double pricePerHour) {
    FirebaseFirestore.instance.collection('parking_spots_for_rent').add({
      'ownerId': ownerId,
      'name': name,
      'address': address,
      'pricePerHour': pricePerHour,
      'isAvailable': true,
    }).then((value) {
      print('Parking spot listed for rent successfully!');
    }).catchError((error) {
      print('Error listing parking spot for rent');
    });
  }

  void _submitListing() {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    double pricePerHour = double.tryParse(_priceController.text.trim()) ?? 0.0;

    if (name.isEmpty || address.isEmpty || pricePerHour <= 0) {
      // Display an error message if any of the fields are empty or invalid
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all the fields.')));
      return;
    }

    listParkingSpotForRent(
      widget.ownerId,
      name,
      address,
      pricePerHour,
    );

    _nameController.clear();
    _addressController.clear();
    _priceController.clear();
  }
}
