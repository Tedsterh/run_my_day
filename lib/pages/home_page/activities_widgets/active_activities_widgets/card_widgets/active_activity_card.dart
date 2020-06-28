import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/neumorphic_card_background.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/neumorphic_expanstion_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/custom/custom_expanstion_tile.dart';

class ActiveActivityCard extends StatefulWidget {
  const ActiveActivityCard({Key key, @required this.activityModel})
      : super(key: key);
  final ActivityModel activityModel;

  @override
  _ActiveActivityCardState createState() => _ActiveActivityCardState();
}

class _ActiveActivityCardState extends State<ActiveActivityCard>
    with SingleTickerProviderStateMixin {
  Stream timeUpdater = Stream.periodic(Duration(seconds: 1));
  GlobalKey<ActivityExpansionTileState> key = GlobalKey();

  AnimationController _animationController;
  Animation animation, heightAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animation = Tween<double>(begin: 30.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    heightAnimation = Tween<double>(begin: 220.0, end: 280.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Stack(
              children: <Widget>[
                NeumorphicCardBackground(
                    animationController: _animationController,
                    heightAnimation: heightAnimation),
                NeumorphicExpansionTile(
                    globalKey: key,
                    animationController: _animationController,
                    widget: widget),
              ],
            ),
          )),
    );
  }
}
