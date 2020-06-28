import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationAction extends StatefulWidget {
  LocationAction(
      {Key key, @required this.actionList, @required this.eventLocation})
      : super(key: key);
  final ValueNotifier<List<String>> actionList;
  final ValueNotifier<LatLng> eventLocation;

  @override
  _LocationActionState createState() => _LocationActionState();
}

class _LocationActionState extends State<LocationAction> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
      child: FutureBuilder<LocationData>(
          future: getLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListTile(
                leading: ValueListenableBuilder<List<String>>(
                    valueListenable: widget.actionList,
                    builder: (context, list, child) {
                      return NeumorphicCheckbox(
                          value: list.contains('location'),
                          onChanged: (value) async {
                            if (value) {
                              List newList =
                                  List<String>.from(widget.actionList.value);
                              newList.add('location');
                              widget.eventLocation.value = LatLng(
                                  snapshot.data.latitude,
                                  snapshot.data.longitude);
                              widget.actionList.value = newList;
                            } else {
                              List newList =
                                  List<String>.from(widget.actionList.value);
                              newList.remove('location');
                              widget.eventLocation.value = null;
                              widget.actionList.value = newList;
                            }
                          });
                    }),
                title: Text('Add location point'),
              );
            } else {
              return ListTile(
                title: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
