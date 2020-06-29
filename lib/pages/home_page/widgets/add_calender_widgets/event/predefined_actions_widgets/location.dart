import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/predefined_actions_widgets/google_map/google_map_popup.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
        child: ListTile(
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
                        LatLng _location = await showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return GoogleMapPopup();
                            });
                        widget.eventLocation.value = _location;
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
        ));
  }
}
