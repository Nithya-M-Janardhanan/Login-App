import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sample_task/map_related/animated_pin.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  String  local='';
  String locality='';
  String newplc='';
  List<Marker> myMarker=[];
  final Map<MarkerId,Marker> _markers=<MarkerId,Marker>{};
   int _markerIdCounter = 0;
  final Completer<GoogleMapController> _controller=Completer();
  static const LatLng _center =  LatLng(10.530345, 76.214729);
  LatLng lastMapPos=_center;
  final Set<Marker> _marker ={};
late Position currentPos;
late GoogleMapController control;
final CameraPosition initial = const CameraPosition(target: LatLng(10.530345, 76.214729),zoom: 14);
  markerAdd()async{
    setState(() {
      Marker marker=Marker(
            markerId: MarkerId(lastMapPos.toString()),
            position: lastMapPos,
            icon: BitmapDescriptor.defaultMarker,
            draggable: true
          );
      // _marker.add(Marker(
      //   markerId: MarkerId(lastMapPos.toString()),
      //   position: lastMapPos,
      //   icon: BitmapDescriptor.defaultMarker,
      //   draggable: true
      // ));
      local=lastMapPos.toString();
    });
  }
  void locatePosition()async{
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPos=position;
    LatLng latLngPos= LatLng(position.latitude, position.longitude);
    debugPrint('*****************$latLngPos ******************');
    CameraPosition camPosition = CameraPosition(target: latLngPos,zoom: 14);
    control.animateCamera(CameraUpdate.newCameraPosition(camPosition));
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

  }
  String _markerIdVal({bool increment = false}){
    String val = 'marker_id_$_markerIdCounter';
    if(increment)_markerIdCounter++;
    return val;
  }

  handleTap(LatLng tappedPoint)async{
    List<Placemark> placemark = await placemarkFromCoordinates(tappedPoint.latitude, tappedPoint.longitude);
    // debugPrint('address.......$placemark');
    Placemark place = placemark[0];
    debugPrint('on tap>>>>>>>>>>$place');
    setState(() {
      myMarker=[];
      myMarker.add(Marker(markerId: MarkerId(tappedPoint.toString()),position: tappedPoint));
    });
  }
  ///current loc
  Future<Position> _determinePosition() async {
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
    return await Geolocator.getCurrentPosition();
  }
///
  /// get address from lat long
  Future<void>getAddressFromLatLong(Position position)async{
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    debugPrint('address.......$placemark');
    Placemark place = placemark[0];
    setState(() {
      locality='${place.locality}';
    });
    debugPrint('locality is ....... $locality');
  }
  ///
  loc()async{
    Position position = await _determinePosition();
    getAddressFromLatLong(position);
  }
  @override
  void initState() {
    loc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(initialCameraPosition: initial,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers.values),
            onCameraMove:
                (CameraPosition position){
              if(_markers.length>0){
                MarkerId markerId=MarkerId(_markerIdVal());
                Marker? marker= _markers[markerId];
                Marker updatedMarker = marker!.copyWith(positionParam: position.target);
                setState(() {
                  _markers[markerId]=updatedMarker;
                });
              }
            },
          onMapCreated: (controller){
            setState(() {
              control=controller;
              locatePosition();
              markerAdd();
            });
          },
            onTap: handleTap,
          ),
           const Center(child: AnimatedPin(child: Icon(Icons.place,size: 36,color: Colors.red,),),)
        ],
      ),
     bottomSheet: Container(
       height: 200,
       child: Column(
         children: [
           ElevatedButton(onPressed: () async {
             Position position = await _determinePosition();
             getAddressFromLatLong(position);
             setState(() {

             });
           }, child: const Text('Use Current Location')),
           Padding(
             padding: const EdgeInsets.only(top: 20,left: 10),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                const Icon(Icons.location_on,color: Colors.red,),
                 Text(locality.isEmpty ? '' : locality),
               ],
             ),
           ),
         ],
       ),
     )
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   markerAdd();
      // },child: const Icon(Icons.zoom_out),),
    );
  }
}
// ElevatedButton(onPressed: ()async{
// Position position = await _determinePosition();
// getAddressFromLatLong(position);
// setState(() {
//
// });
// }, child: const Text('Use Current Location'))