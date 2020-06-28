import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventLocationGoogleMap extends StatelessWidget {
  EventLocationGoogleMap({
    Key key,
    @required this.location,
  }) : super(key: key);

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{
      MarkerId('eventLocation'):
          Marker(markerId: MarkerId('eventLocation'), position: location)
    };
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
            intensity: 1.0,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
        child: Container(
          height: 130,
          child: Hero(
            tag: 'googleMap',
            child: GoogleMap(
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(target: location, zoom: 16),
                markers: Set<Marker>.of(markers.values)),
          ),
        ),
      ),
    );
  }
}