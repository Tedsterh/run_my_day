import 'package:flutter/material.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_action_buttons/silence_notification_action_button.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key key, @required this.actions}) : super(key: key);
  final List<String> actions;

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
                : Container()
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

