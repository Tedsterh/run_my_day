import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/action_buttons.dart';
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

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes M";
  }

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
    heightAnimation = Tween<double>(begin: 180.0, end: 240.0).animate(
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
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, snapshot) {
                    return Neumorphic(
                      style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft:
                                      Radius.circular(30),
                                  bottomRight:
                                      Radius.circular(30))),
                          depth: -30,
                          intensity: 1.0),
                      child: Container(
                        width: double.infinity,
                        height: heightAnimation.value,
                      ),
                    );
                  }
                ),
                ActivityExpansionTile(
                  key: key,
                  onExpansionChanged: (value) {
                    if (value) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                  },
                  title: Stack(
                    children: <Widget>[
                      Neumorphic(
                        style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(30)),
                            shape: NeumorphicShape.concave),
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 40,
                                          width: 100,
                                          child: SvgPicture.asset(
                                              widget.activityModel.iconName),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        widget.activityModel.eventName,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      SizedBox(width: 30),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _printDuration(widget.activityModel.duration),
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      SizedBox(width: 30),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      child: Container(
                        color: Colors.transparent,
                        child: ActionButtons(
                          actions: widget.activityModel.eventActions
                        )
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
