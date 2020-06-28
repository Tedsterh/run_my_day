import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/custom/custom_expanstion_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/predefined_actions_widgets/do_not_disturb.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/predefined_actions_widgets/location.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/predefined_actions_widgets/movie_time.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/predefined_actions_widgets/track_walk.dart';

class AddPredefinedActions extends StatefulWidget {
  AddPredefinedActions({
    Key key,
    @required this.scrollController,
    @required this.actionList,
    @required this.eventLocation,
    @required this.movieID
  }) : super(key: key);
  final ScrollController scrollController;  
  final ValueNotifier<List<String>> actionList;
  final ValueNotifier<LatLng> eventLocation;
  final ValueNotifier<String> movieID;

  @override
  _AddPredefinedActionsState createState() => _AddPredefinedActionsState();
}

class _AddPredefinedActionsState extends State<AddPredefinedActions> {
  ValueNotifier<bool> switchNotfier = ValueNotifier(false);
  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.16,
        child: AppExpansionTile(
          key: expansionTile,
          title: Text(
            'Add Actions',
            style: TextStyle(
              fontSize: 20
            ),
          ),
          trailing: ValueListenableBuilder<bool>(
            valueListenable: switchNotfier,
            builder: (context, switchNotification, child) {
              return NeumorphicSwitch(
                value: switchNotification,
                height: 30,
                onChanged: (value) {
                  switchNotfier.value = value;
                  if (value) {
                    expansionTile.currentState.expand();
                    if (widget.scrollController.hasClients) {
                      widget.scrollController.animateTo(widget.scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
                    }
                  } else {
                    expansionTile.currentState.collapse();
                    if (widget.scrollController.hasClients) {
                      widget.scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
                    }
                  }
                },
              );
            }
          ),
          children: <Widget>[
            DoNotDisturbAction(
              actionList: widget.actionList
            ),
            TrackWalkAction(
              actionList: widget.actionList
            ),
            LocationAction(
              actionList: widget.actionList,
              eventLocation: widget.eventLocation,
            ),
            MovieTimeAction(
              actionList: widget.actionList,
              movieID: widget.movieID,
            )
          ],
        ),
      ),
    );
  }
}