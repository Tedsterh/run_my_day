import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity/active_activities/bloc/active_activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_action_buttons/silence_notification_action_button.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key key, @required this.actions, @required this.activityID}) : super(key: key);
  final List<String> actions;
  final String activityID;

  @override
  Widget build(BuildContext context) {
    if (actions.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ListView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                actions.contains('doNotDisturb')
                    ? SilenceNotificationsButton.create(context)
                    : Container(),
                FlatButton(
                    onPressed: () {
                      BlocProvider.of<ActiveActivitiesBloc>(context)
                          .add(EndEarly(activityID));
                    },
                    child: NeumorphicText(
                      'End early',
                      style: NeumorphicStyle(color: Color(0xFF7D9DFD)),
                    ))
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
