import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/activity_card_widgets/action_buttons.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityCard extends StatefulWidget {
  const ActivityCard({Key key, @required this.activityModel}) : super(key: key);
  final ActivityModel activityModel;

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  DateTime get startTime => widget.activityModel.startTime;
  DateTime get endTime => widget.activityModel.endTime;

  bool get isActive =>
      DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);

  double get cardHeight => widget.activityModel.eventActions.length != 0
      ? isActive ? 190 : 140
      : 140;

  Stream timeUpdater = Stream.periodic(Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Neumorphic(
          style: NeumorphicStyle(
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(30))),
          child: Container(
            height: cardHeight,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              widget.activityModel.eventName,
                              style: TextStyle(
                                fontSize: 22
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              child: Text(
                                widget.activityModel.description,
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ),
                            SizedBox(height: 0),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 30,
                              child: StreamBuilder(
                                stream: timeUpdater,
                                builder: (context, snapshot) {
                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: widget.activityModel.startTime.isAfter(DateTime.now()) ? 'Starts in' : 'Ends in',
                                          style: Theme.of(context).textTheme.subtitle1.copyWith(

                                          )
                                        ),
                                        TextSpan(
                                          text: '  ',
                                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                            
                                          )
                                        ),
                                        TextSpan(
                                          text: widget.activityModel.startTime.isAfter(DateTime.now()) ? timeago.format(widget.activityModel.startTime, allowFromNow: true) : timeago.format(widget.activityModel.endTime, allowFromNow: true, locale: 'en_short'),
                                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                            
                                          )
                                        )
                                      ]
                                    )
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 130,
                          width: 100,
                          child:
                              SvgPicture.asset(widget.activityModel.iconName),
                        ),
                        SizedBox(width: 20)
                      ],
                    )
                  ],
                ),
                ActionButtons(
                  actions: widget.activityModel.eventActions,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
