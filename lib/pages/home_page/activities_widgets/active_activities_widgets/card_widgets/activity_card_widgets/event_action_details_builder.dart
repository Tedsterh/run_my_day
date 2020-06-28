import 'package:flutter/material.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/event_details_google_map.dart';

class EventActionDetails extends StatelessWidget {
  const EventActionDetails({Key key, @required this.activityModel})
      : super(key: key);
  final ActivityModel activityModel;

  @override
  Widget build(BuildContext context) {
    if (activityModel.eventActions.contains('location')) {
      return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: EventLocationGoogleMap(location: activityModel.eventLocation),
        ),
      );
    }
    return Container();
  }
}