import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parko/assistants/request_assistant.dart';
import 'package:parko/credentials/credentials.dart';
import 'package:parko/dataHandler/app_data.dart';
import 'package:parko/models/address.dart';
import 'package:parko/models/direction_details.dart';
import 'package:provider/provider.dart';

class AssistantMethods {
  static Future searchCoordinatesAddress(Position position, context) async {
    String placeAddress = '';
    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${Credentials.apiKey}';

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      // placeAddress = response['results'][0]['formatted_address'];
      var st1 = response['results'][0]['address_components'][0]['long_name'];
      var st2 = response['results'][0]['address_components'][1]['long_name'];
      var st3 = response['results'][0]['address_components'][5]['long_name'];
      var st4 = response['results'][0]['address_components'][6]['long_name'];

      placeAddress = st1 + ',' + st2 + ',' + st3 + ',' + st4;

      Address userCurrentAddress = Address(
          placeFormattedAddress: '',
          placeName: '',
          placeId: '',
          latitude: 0.0,
          longitude: 0.0);
      userCurrentAddress.longitude = position.longitude;
      userCurrentAddress.latitude = position.latitude;
      userCurrentAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updateCurrentLocationAddress(userCurrentAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails?> obtainedPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=${Credentials.apiKey}";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails(
        distanceValue: 0,
        durationValue: 0,
        distanceText: '',
        durationText: '',
        encodedPoints: '');

    directionDetails.encodedPoints =
        res['routes'][0]['overview_polyline']['points'];
    directionDetails.distanceText =
        res['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        res['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.durationText =
        res['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        res['routes'][0]['legs'][0]['duration']['value'];

    return directionDetails;
  }
}
