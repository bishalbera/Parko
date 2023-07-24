import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parko/assistants/request_assistant.dart';
import 'package:parko/common/progress_dialog.dart';
import 'package:parko/credentials/credentials.dart';
import 'package:parko/dataHandler/app_data.dart';
import 'package:parko/models/address.dart';
import 'package:parko/models/place_predictions.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController currentTextEditingController = TextEditingController();
  TextEditingController destinationTextEditingController =
      TextEditingController();

  List<PlacePredictions> placePredictionsList = [];

  @override
  Widget build(BuildContext context) {
    String currentAddress =
        Provider.of<AppData>(context).currentLocation.placeName ?? "";
    currentTextEditingController.text = currentAddress;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 215.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, top: 25.0, right: 35.0, bottom: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back)),
                          const Center(
                            child: Text(
                              'Search Places',
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: 'Brand-Bold'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 16.0,
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(
                                  controller: currentTextEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'Current Location',
                                    fillColor: Colors.grey[400],
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 11.0, top: 8.0, bottom: 8.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16.0,
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextField(
                                  onChanged: (val) {
                                    findPlace(val);
                                  },
                                  controller: destinationTextEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'Destination Location',
                                    fillColor: Colors.grey[400],
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 11.0, top: 8.0, bottom: 8.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //tile for place predictions
              const SizedBox(
                height: 10.0,
              ),
              (placePredictionsList.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(0.0),
                        itemBuilder: (context, index) {
                          return PredictionTile(
                            placePredictions: placePredictionsList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: 1.0,
                        ),
                        itemCount: placePredictionsList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=${Credentials.apiKey}";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == 'failed') {
        return;
      }
      if (res['status'] == 'OK') {
        var predictions = res['predictions'];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        setState(() {
          placePredictionsList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;

  PredictionTile({super.key, required this.placePredictions});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                const Icon(Icons.add_location),
                SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(message: 'Please wait...'));

    String placeDetailUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${Credentials.apiKey}";
    var res = await RequestAssistant.getRequest(placeDetailUrl);

    Navigator.pop(context);

    if (res == 'failed') {
      return;
    }
    if (res['status'] == 'OK') {
      Address address = Address(
          placeFormattedAddress: '',
          placeName: '',
          placeId: '',
          latitude: 0.0,
          longitude: 0.0);

      address.placeName = res['result']['name'];
      address.placeId = placeId;
      address.latitude = res['result']['geometry']['location']['lat'];
      address.longitude = res['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false)
          .updateDestinationLocationAddress(address);

      if (kDebugMode) {
        print('Destination Address ${address.placeName}');
      }
      Navigator.pop(context, 'obtainDirection');
    }
  }
}
