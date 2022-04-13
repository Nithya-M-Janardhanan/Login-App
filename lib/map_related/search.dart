import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
class SearchLoc extends StatefulWidget {
  @override
  _SearchLocState createState() => _SearchLocState();
}

class _SearchLocState extends State<SearchLoc> {
  static const googleApiKey = 'AIzaSyDD6jZIHJrORmNnHMdjRKMkrUOazF2LITs';
  TextEditingController textController = TextEditingController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: SafeArea(
        child: TextField(
          onChanged: (value){
            findPlace(value);
          },
          controller: textController,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 3.0)
              ),
              hintText: 'Search name'
          ),
        ),
      ),
    );
  }
  void findPlace(String placeName) async{
    if(placeName.length > 1){
      String autoCompleteUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$googleApiKey';
      var client = http.Client();
      Response res = await client.get(Uri.parse(autoCompleteUrl));
      if(res.statusCode==200){
        var result = res.body;
        debugPrint('>>>>>>>>>>>>length ${result.length}');
        debugPrint('>>>>>>>>>>>>$result');
      }
      // if(res == 'failed'){
      //   return;
      // }
      //   var result = res.body;
      // debugPrint('>>>>>>>>>>>>length ${result.length}');
      // debugPrint('>>>>>>>>>>>>$result');
    }
  }
  Future<void> searchPlace() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: googleApiKey,
        language: 'en',
        mode: Mode.overlay,
        strictbounds: false,
        types: [''],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country, 'in')]);
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: googleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    final GoogleMapController controller = await _controller.future;
    setState(() {
      controller
          .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
    });
  }
}
