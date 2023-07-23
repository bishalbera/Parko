// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookingModel {
  final String bookerUid;
  final String bookerName;
  final String bookerVehicle;
  final String bookerTime;
  final String address;
  final String date;
  final String pricePerHour;
  final String lat;
  final String long;
  BookingModel({
    required this.bookerUid,
    required this.bookerName,
    required this.bookerVehicle,
    required this.bookerTime,
    required this.address,
    required this.date,
    required this.pricePerHour,
    required this.lat,
    required this.long,
  });

  BookingModel copyWith({
    String? bookerUid,
    String? bookerName,
    String? bookerVehicle,
    String? bookerTime,
    String? address,
    String? date,
    String? pricePerHour,
    String? lat,
    String? long,
  }) {
    return BookingModel(
      bookerUid: bookerUid ?? this.bookerUid,
      bookerName: bookerName ?? this.bookerName,
      bookerVehicle: bookerVehicle ?? this.bookerVehicle,
      bookerTime: bookerTime ?? this.bookerTime,
      address: address ?? this.address,
      date: date ?? this.date,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookerUid': bookerUid,
      'bookerName': bookerName,
      'bookerVehicle': bookerVehicle,
      'bookerTime': bookerTime,
      'address': address,
      'date': date,
      'pricePerHour': pricePerHour,
      'lat': lat,
      'long': long,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookerUid: map['bookerUid'] as String,
      bookerName: map['bookerName'] as String,
      bookerVehicle: map['bookerVehicle'] as String,
      bookerTime: map['bookerTime'] as String,
      address: map['address'] as String,
      date: map['date'] as String,
      pricePerHour: map['pricePerHour'] as String,
      lat: map['lat'] as String,
      long: map['long'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) => BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingModel(bookerUid: $bookerUid, bookerName: $bookerName, bookerVehicle: $bookerVehicle, bookerTime: $bookerTime, address: $address, date: $date, pricePerHour: $pricePerHour, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(covariant BookingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.bookerUid == bookerUid &&
      other.bookerName == bookerName &&
      other.bookerVehicle == bookerVehicle &&
      other.bookerTime == bookerTime &&
      other.address == address &&
      other.date == date &&
      other.pricePerHour == pricePerHour &&
      other.lat == lat &&
      other.long == long;
  }

  @override
  int get hashCode {
    return bookerUid.hashCode ^
      bookerName.hashCode ^
      bookerVehicle.hashCode ^
      bookerTime.hashCode ^
      address.hashCode ^
      date.hashCode ^
      pricePerHour.hashCode ^
      lat.hashCode ^
      long.hashCode;
  }
}

