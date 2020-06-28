import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:run_my_lockdown/blocs/activity/completed_activities/bloc/completed_activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity_actions/do_not_disturb/bloc/do_not_disturb_bloc.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/custom/custom_expanstion_tile.dart';
import 'package:run_my_lockdown/repositories/silence_notifications_repository/implementations/android_silence_notifications_repository.dart';
import 'package:run_my_lockdown/repositories/silence_notifications_repository/implementations/ios_silence_notifications_repository.dart';

class CompletedActivityCard extends StatefulWidget {
  const CompletedActivityCard({Key key, @required this.activityModel})
      : super(key: key);
  final ActivityModel activityModel;

  @override
  _CompletedActivityCardState createState() => _CompletedActivityCardState();
}

class _CompletedActivityCardState extends State<CompletedActivityCard>
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
    heightAnimation = Tween<double>(begin: 120.0, end: 180.0).animate(
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
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            depth: -30,
                            intensity: 1.0),
                        child: Container(
                          width: double.infinity,
                          height: heightAnimation.value,
                        ),
                      );
                    }),
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
                          shape: NeumorphicShape.concave,
                        ),
                        child: Container(
                          height: 120,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _printDuration(
                                            widget.activityModel.duration),
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      SizedBox(width: 30),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Started at',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          DateFormat('HH:MM:ss').format(
                                              widget.activityModel.startTime),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Ended at',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          DateFormat('HH:MM:ss').format(
                                              widget.activityModel.endTime),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
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
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(30))),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                BlocProvider.of<CompletedActivitiesBloc>(
                                        context)
                                    .add(AddToTomorrow(
                                        widget.activityModel.eventID));
                              },
                              child: NeumorphicText(
                                'Add again tomorrow',
                                style:
                                    NeumorphicStyle(color: Color(0xFF7D9DFD)),
                              ),
                            ),
                            widget.activityModel.eventActions
                                    .contains('doNotDisturb')
                                ? NotificationsEnableButton.create(context)
                                : Container()
                          ],
                        ),
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

class NotificationsEnableButton extends StatelessWidget {
  const NotificationsEnableButton({
    Key key,
  }) : super(key: key);

  static Widget create(context) {
    return BlocProvider<DoNotDisturbBloc>(
      create: (context) => DoNotDisturbBloc(
          notificationsRepository: Platform.isAndroid
              ? AndroidSilenceNotificationsRepository()
              : IosSilenceNotificationsRepository())
        ..add(CheckSilenceNotificationStatus()),
      child: NotificationsEnableButton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        BlocProvider.of<DoNotDisturbBloc>(context)
            .add(TurnOffSilentNotificatins());
      },
      child: NeumorphicText(
        'Enable Notifications',
        style: NeumorphicStyle(color: Color(0xFF7D9DFD)),
      ),
    );
  }
}
