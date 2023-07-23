import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parko/common/bottom_navigation_bar.dart';
import 'package:parko/common/constants/constants.dart';
import 'package:parko/common/constants/utils.dart';
import 'package:parko/features/models/parking_spot_for_rent.dart';

import '../../booking/screens/booking_screen.dart';
import 'list_parking_spot_screen.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  GoogleMapController? _mapController;
  GeoFlutterFire _geo = GeoFlutterFire();
  Set<Marker> _parkingMarkers = {};
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 20.4746,
  );

  @override
  void initState() {
    super.initState();
    fetchNearbyParkingSpotsAndUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Spots'),
      ),
      bottomNavigationBar: MyCustomBottomNavigationBar(),
      drawer: buildStylishDrawer(context),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        buildingsEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (controller) {
          _mapController = controller;
          fetchNearbyParkingSpotsAndUserLocation();
        },
        markers: _parkingMarkers,
      ),
    );
  }

  CollectionReference _parkingCollection =
      FirebaseFirestore.instance.collection('parking_spots');

  String? locationData; // Store the geohash string of the current location

  //Function to get the users currents location
  Future<Position> _getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      throw Exception('Location service is not enabled.');
    }
  }

  // Function to fetch nearby parking spots from firestore and update the markers list
  void fetchNearbyParkingSpotsAndUserLocation() async {
    try {
      // Get the users current location
      Position userPosition = await _getCurrentLocation();

      // Add a marker for the user's location
      _parkingMarkers.add(
        Marker(
          markerId: MarkerId('userLocation'),
          position: LatLng(userPosition.latitude, userPosition.longitude),
          infoWindow: InfoWindow(title: 'My Location'),
          onTap: () {
            _onMarkerTapped(MarkerId('userLocation'));
          },
        ),
      );

      // Create a GeoFirePoint for the user's location
      GeoFirePoint userGeoPoint = _geo.point(
        latitude: userPosition.latitude,
        longitude: userPosition.longitude,
      );

      // Set the radius for nearby parking search (in KM)
      double radius = 2.0;

      // Perform a query to get nearby parking spots
      Stream<List<DocumentSnapshot>> stream = _geo
          .collection(collectionRef: _parkingCollection)
          .within(center: userGeoPoint, radius: radius, field: 'location');

      // Listen to the stream and update the markers list accordingly
      stream.listen((List<DocumentSnapshot> documentList) {
        List<Marker> markers = [];

        documentList.forEach((DocumentSnapshot document) {
          GeoPoint geoPoint = document['location']['geopoint'];
          String parkingSpotId = document.id;
          String parkingSpotName = document['name'];
          String parkingSpotAddress = document['address'];
          bool isParkingSpotAvailable = document['isAvailable'];
          double pricePerHour = document['pricePerHour'];

          // Create a marker for parking spot
          if (isParkingSpotAvailable) {
            Marker marker = Marker(
              markerId: MarkerId(parkingSpotId),
              infoWindow: InfoWindow(
                title: parkingSpotName,
                snippet: 'Price: $pricePerHour',
              ),
              position: LatLng(geoPoint.latitude, geoPoint.longitude),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                showParkingDetails(
                  ParkingSpotForRent(
                    id: parkingSpotId,
                    name: parkingSpotName,
                    latitude: geoPoint.latitude,
                    longitude: geoPoint.longitude,
                    address: parkingSpotAddress,
                    isParkingSpotAvailable: isParkingSpotAvailable,
                    pricePerHour: pricePerHour,
                  ),
                );
              },
            );
            markers.add(marker);
          }
        });

        setState(() {
          _parkingMarkers = Set<Marker>.from(markers);
          _parkingMarkers.add(
            Marker(
              markerId: MarkerId('userLocation'),
              position: LatLng(userPosition.latitude, userPosition.longitude),
              infoWindow: InfoWindow(title: 'My Location'),
              onTap: () {
                _onMarkerTapped(MarkerId('userLocation'));
              },
            ),
          );
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching nearby parking spots: $e');
      }
    }
  }

  Future<void> _onMarkerTapped(MarkerId markerId) async {
    var pos = await _getCurrentLocation();
    GeoFirePoint point =
        await _geo.point(latitude: pos.latitude, longitude: pos.longitude);
    // Create a GeoFirePoint for the users location
    String placeName = await getAddressFromLatLng(pos.latitude, pos.longitude);
    locationData = point.hash; // Store the geohash string in locationData
    print('the point data is ${locationData}');
    if (markerId.value == 'userLocation') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListParkingSpotScreen(
            ownerId: ownerId!, // Replace ownerId with the actual owner ID
            placeName: placeName,
          ),
        ),
      );
    }
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = "${place.name}, ${place.locality}, ${place.country}";
        return address;
      }
    } catch (e) {
      print("Error: $e");
    }
    return "Address not found";
  }

  // Function to show parking details when a marker is tapped
  void showParkingDetails(ParkingSpotForRent parkingSpot) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          title: Text(parkingSpot.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Address: ${parkingSpot.address}'),
              Text(
                'Availability: ${parkingSpot.isParkingSpotAvailable ? 'Available' : 'Occupied'}',
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                moveScreen(context, BookingScreen(parkingSpot: parkingSpot));
              },
              child: const Text('Book a spot'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
