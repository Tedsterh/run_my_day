import 'package:flutter/material.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/active_activity_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleDetails extends StatelessWidget {
  const TitleDetails({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ActiveActivityCard widget;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes M";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                width: 100,
                child: SvgPicture.asset(widget.activityModel.iconName),
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
    );
  }
}