import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/auth_provider.dart';
import '../common/sharedpreferences.dart';
import '../generated/l10n.dart';


class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  Completer<GoogleMapController> _controller = Completer();
  Position? currentPosition;
  LatLng? latLong;
    double currntLat=10.5276;
   double currntLng=76.2144;
  bool locating = false;
  Placemark? placemark;
  String locality = '';
  String storedName = '';
  static const kGoogleApiKey = 'AIzaSyDGukTyc_pEg-UeeGoP0h63z0DMCdC8zZw';
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();
  String location = "Search Location";

  static const CameraPosition kGooglePlex =
      CameraPosition(target: LatLng(10.5276, 76.2144), zoom: 14);

  Future<Position> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentPosition = await getLocationPermission();
    gotoCurrentPosition(
        LatLng(currentPosition!.latitude, currentPosition!.longitude));
    //currntLat=currentPosition!.latitude;
    //currntLng=currentPosition!.longitude;
  }

  Future<void> gotoCurrentPosition(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latLng.latitude, latLng.longitude), zoom: 14)));
        currntLat=latLng.latitude;
        currntLng=latLng.longitude;
  }

  getUserAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLong!.latitude, latLong!.longitude);
    setState(() {
      placemark = placemarks.first;
      locality = placemark!.locality!;
    });
  }

  getLocName() async {
    await SharedPreferenceHelper.getLocation().then((value) {
      setState(() {
        storedName = value;
      });
    });
  }

  @override
  void initState() {
    getUserLocation();
    getLocName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        key: homeScaffoldKey,
        appBar: AppBar(
          title:  Text(translated.chooseLocation),
        ),
        body: Column(children: [
            Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * .55,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Stack(children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(currntLat,currntLng), zoom: 14),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      locating = true;
                      latLong = position.target;
                      storedName = '';
                    });
                  },
                  onCameraIdle: () {
                    setState(() {
                      locating = false;
                    });
                    getUserAddress();
                  },
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    size: 50,
                  ),
                )
              ]),
            ),
          ]),
          Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  getUserLocation();
                  getUserAddress();
                },
                child:  Text(
                  translated.useCurrentLocation,
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(width: 1, color: Colors.grey)),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      //Text(locating?'':locality,style: const TextStyle(fontSize: 15),),
                      Text(
                        storedName.isNotEmpty
                            ? storedName
                            : locating
                                ? ''
                                : locality,
                        style: const TextStyle(fontSize: 15),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20.0),
                      //   child: GestureDetector(child: const Text('CHANGE'),onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchLoc()));
                      //     //searchPlace();
                      //   },),
                      // )
                    ],
                  )),
              ElevatedButton(
                onPressed: () async {
                  if (locality.isNotEmpty) {
                    //await SharedPreferenceHelper.setLocation(locality);
                    Provider.of<AuthProvider>(context,listen: false).setLocationName(locality);
                    Navigator.pop(context);
                   // Navigator.pushReplacementNamed(context, accountScreenRoute,arguments: locality??" ");
                  }
                },
                child:  Text(
                  translated.confirmLocation,
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(width: 1, color: Colors.grey)),
              ),
            ],
          ),
        ]));
  }

  Future<void> searchPlace() async {
    final center = await getUserLocation();
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        language: 'en',
        radius: 100000,
        mode: Mode.overlay,
        strictbounds: false,
        types: [''],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [Component(Component.country, 'in')]);
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
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

