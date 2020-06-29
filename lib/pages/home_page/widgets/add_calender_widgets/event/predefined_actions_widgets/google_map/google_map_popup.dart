import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';

class GoogleMapPopup extends StatefulWidget {
  GoogleMapPopup({Key key}) : super(key: key);

  @override
  _GoogleMapPopupState createState() => _GoogleMapPopupState();
}

class _GoogleMapPopupState extends State<GoogleMapPopup> {
  Future<LocationData> getLocation() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LocationData _locationData = await location.getLocation();
    return _locationData;
  }

  Location location = new Location();

  PermissionStatus _permissionGranted;

  ValueNotifier<LatLng> locationData = ValueNotifier(null);

  Completer<GoogleMapController> _controller = Completer();

  ValueNotifier<Map<MarkerId, Marker>> marker = ValueNotifier({});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(0),
            content: Builder(builder: (context) {
              var width = MediaQuery.of(context).size.width - 25;
              var height = MediaQuery.of(context).size.height - 200;
              return FutureBuilder<LocationData>(
                  future: getLocation(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ValueListenableBuilder<
                                        Map<MarkerId, Marker>>(
                                    valueListenable: marker,
                                    builder: (context, markers, child) {
                                      return GoogleMap(
                                          zoomControlsEnabled: false,
                                          onTap: (value) async {
                                            marker.value = <MarkerId, Marker>{
                                              MarkerId('eventLocation'): Marker(
                                                  markerId:
                                                      MarkerId('eventLocation'),
                                                  position: LatLng(
                                                      value.latitude,
                                                      value.longitude))
                                            };
                                            final GoogleMapController
                                                controller =
                                                await _controller.future;
                                            controller.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                    CameraPosition(
                                                        target: LatLng(
                                                            value.latitude,
                                                            value.longitude),
                                                        zoom: 16)));
                                          },
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                          markers:
                                              Set<Marker>.of(markers.values),
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                  snapshot.data.latitude,
                                                  snapshot.data.longitude)));
                                    }),
                              ),
                            ),
                            Positioned(
                                top: 20,
                                left: 20,
                                right: 20,
                                child: SearchMapPlaceWidget(
                                  apiKey:
                                      'AIzaSyA3DOz6Nzqig2DNiIvOI6wDHAjxqTttGpk',
                                  language: 'en',
                                  radius: 30000,
                                  location: LatLng(snapshot.data.latitude,
                                      snapshot.data.longitude),
                                  onSelected: (value) async {
                                    Geolocation geo = await value.geolocation;
                                    locationData.value = LatLng(
                                        geo.coordinates.latitude,
                                        geo.coordinates.longitude);
                                    marker.value = <MarkerId, Marker>{
                                      MarkerId('eventLocation'): Marker(
                                          markerId: MarkerId('eventLocation'),
                                          position: LatLng(
                                              geo.coordinates.latitude,
                                              geo.coordinates.longitude))
                                    };
                                    final GoogleMapController controller =
                                        await _controller.future;
                                    controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(
                                                    geo.coordinates.latitude,
                                                    geo.coordinates.longitude),
                                                zoom: 16)));
                                  },
                                )),
                            Positioned(
                                right: 20,
                                bottom: 20,
                                child: NeumorphicButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(locationData.value);
                                  },
                                  child: Text(
                                    'Select',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ))
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  });
            })));
  }
}
