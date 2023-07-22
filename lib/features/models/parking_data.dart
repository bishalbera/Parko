import 'package:geoflutterfire2/geoflutterfire2.dart';

class ParkingData {
  final String id;
  final GeoFirePoint location;
  final bool isAvailable;
  final String name;
  final String address;

  ParkingData({
    required this.id,
    required this.location,
    required this.isAvailable,
    required this.name,
    required this.address,
  });
}
