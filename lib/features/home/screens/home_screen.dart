import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parko/assistants/assistant_methods.dart';
import 'package:parko/common/constants/constants.dart';

import 'package:parko/common/progress_dialog.dart';
import 'package:parko/dataHandler/app_data.dart';
import 'package:parko/features/search/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../../common/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  late GoogleMapController newGoogleMapController;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  late Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  Future locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    var address =
        await AssistantMethods.searchCoordinatesAddress(position, context);
    if (kDebugMode) {
      print("This is current address $address");
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyCustomBottomNavigationBar(),
      drawer: buildStylishDrawer(context),
      appBar: AppBar(
        elevation: 4.0,
        title: const Text('Home'),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              locatePosition();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 18.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      'Hi there, $userName!',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                        if (res == "obtainDirection") {
                          await getPlaceDirection();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text('Search Places')
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 270,
                              child: Text(
                                Provider.of<AppData>(context)
                                    .currentLocation
                                    .placeName,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            const Text(
                              'Current Address',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    final appData = Provider.of<AppData>(context, listen: false);

    final initialPos = appData.currentLocation;
    final destinationPos = appData.destinationLocation;

    final currentLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    final destinationLatLng =
        LatLng(destinationPos.latitude, destinationPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(message: 'Please wait...'));

    final details = await AssistantMethods.obtainedPlaceDirectionDetails(
        currentLatLng, destinationLatLng);

    // Access context again here
    Navigator.pop(context);

    if (kDebugMode) {
      print('This is the encodedPoints ${details?.encodedPoints}');
    }

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolylinePointResults =
        polylinePoints.decodePolyline(details!.encodedPoints);

    pLineCoordinates.clear();

    if (decodePolylinePointResults.isNotEmpty) {
      decodePolylinePointResults.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId('PolylineId'),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (currentLatLng.latitude > destinationLatLng.latitude &&
        currentLatLng.longitude > destinationLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: destinationLatLng, northeast: currentLatLng);
    } else if (currentLatLng.longitude > destinationLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest:
              LatLng(currentLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, currentLatLng.longitude));
    } else if (currentLatLng.latitude > destinationLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest:
              LatLng(destinationLatLng.latitude, currentLatLng.longitude),
          northeast:
              LatLng(currentLatLng.latitude, destinationLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: currentLatLng, northeast: destinationLatLng);
    }

    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker currentLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
        title: initialPos.placeName,
        snippet: "Current Location",
      ),
      position: currentLatLng,
      markerId: MarkerId('currentLocationId'),
    );

    Marker destinationLocationMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: destinationPos.placeName,
        snippet: "Destination Location",
      ),
      position: destinationLatLng,
      markerId: MarkerId('destinationLocationId'),
    );

    setState(() {
      markersSet.add(currentLocationMarker);
      markersSet.add(destinationLocationMarker);
    });

    Circle currentLocationCircle = Circle(
      fillColor: Colors.blueAccent,
      center: currentLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId('currentLocationId'),
    );

    Circle destinationLocationCircle = Circle(
      fillColor: Colors.purpleAccent,
      center: destinationLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.purpleAccent,
      circleId: CircleId('destinationLocationId'),
    );

    setState(() {
      circlesSet.add(currentLocationCircle);
      circlesSet.add(destinationLocationCircle);
    });
  }
}
