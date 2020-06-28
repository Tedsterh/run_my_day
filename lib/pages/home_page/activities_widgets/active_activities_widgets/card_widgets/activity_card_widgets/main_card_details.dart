import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/active_activity_card.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/event_action_details_builder.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/activity_card_widgets/title_details.dart';

class NeumorphicMainCardDetails extends StatelessWidget {
  NeumorphicMainCardDetails({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ActiveActivityCard widget;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}Hr ${twoDigitMinutes}M ${twoDigitSeconds}s";
  }

  final Stream periodic =
      Stream.periodic(Duration(seconds: 1)).asBroadcastStream();

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          shape: NeumorphicShape.concave),
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            TitleDetails(widget: widget),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 10),
                        child: Text(
                          widget.activityModel.description,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      StreamBuilder(
                          stream: periodic,
                          builder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.activityModel.startTime
                                                .isBefore(DateTime.now())
                                            ? 'Started at'
                                            : 'Starts in',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      widget.activityModel.startTime
                                              .isAfter(DateTime.now())
                                          ? Text(
                                              _printDuration(Duration(
                                                  milliseconds: widget
                                                      .activityModel.startTime
                                                      .difference(
                                                          DateTime.now())
                                                      .inMilliseconds)),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              DateFormat('HH:MM:ss').format(
                                                  widget
                                                      .activityModel.startTime),
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
                                        widget.activityModel.endTime
                                                .isBefore(DateTime.now())
                                            ? 'Ended at'
                                            : widget.activityModel.startTime
                                                    .isAfter(DateTime.now())
                                                ? 'Ends at'
                                                : 'Ends in',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      widget.activityModel.endTime
                                                  .isAfter(DateTime.now()) &&
                                              !widget.activityModel.startTime
                                                  .isAfter(DateTime.now())
                                          ? Text(
                                              _printDuration(Duration(
                                                  milliseconds: widget
                                                      .activityModel.endTime
                                                      .difference(
                                                          DateTime.now())
                                                      .inMilliseconds)),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              DateFormat('HH:MM:ss').format(
                                                  widget.activityModel.endTime),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
                EventActionDetails(
                  activityModel: widget.activityModel,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}