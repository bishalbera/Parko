import 'package:flutter/material.dart';
import 'package:parko/models/address.dart';

class AppData extends ChangeNotifier {
  late Address currentLocation, destinationLocation;

  AppData() {
    currentLocation = Address(
        placeFormattedAddress: '',
        placeName: '',
        placeId: '',
        latitude: 0.0,
        longitude: 0.0); // initialize currentLocation
  }

  void updateCurrentLocationAddress(Address currentAddress) {
    currentLocation = currentAddress;
    notifyListeners();
  }

  void updateDestinationLocationAddress(Address destinationAddress) {
    destinationLocation = destinationAddress;
    notifyListeners();
  }
}
