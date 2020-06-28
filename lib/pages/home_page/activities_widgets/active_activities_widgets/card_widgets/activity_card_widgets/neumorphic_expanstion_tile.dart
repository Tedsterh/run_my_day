import 'package:flutter/material.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/active_activity_card.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/action_buttons.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/main_card_details.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/custom/custom_expanstion_tile.dart';

class NeumorphicExpansionTile extends StatelessWidget {
  const NeumorphicExpansionTile({
    Key key,
    @required this.globalKey,
    @required this.currentLookingAt,
    @required AnimationController animationController,
    @required this.widget,
  })  : _animationController = animationController,
        super(key: key);

  final GlobalKey<ActivityExpansionTileState> globalKey;
  final AnimationController _animationController;
  final ActiveActivityCard widget;
  final DateTime currentLookingAt;

  @override
  Widget build(BuildContext context) {
    return ActivityExpansionTile(
      key: key,
      currentLookingAt: currentLookingAt,
      onExpansionChanged: (value) {
        if (value) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      title: Stack(
        children: <Widget>[
          NeumorphicMainCardDetails(widget: widget),
        ],
      ),
      children: <Widget>[
        SizedBox(
          height: 60,
          child: Container(
              color: Colors.transparent,
              child: ActionButtons(actions: widget.activityModel.eventActions, activityID: widget.activityModel.eventID,)),
        )
      ],
    );
  }
}