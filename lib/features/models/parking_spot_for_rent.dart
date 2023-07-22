class ParkingSpotForRent {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final bool isParkingSpotAvailable;
  final double pricePerHour;

  ParkingSpotForRent(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.isParkingSpotAvailable,
      required this.pricePerHour});
}
