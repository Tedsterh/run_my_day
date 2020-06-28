import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key key, this.onPressed, @required this.currentDate})
      : super(key: key);
  final VoidCallback onPressed;
  String title;
  final DateTime currentDate;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().toUtc().add(Duration(days: 1));

    if (DateFormat('yyyy-DD-MM').format(currentDate) == DateFormat('yyyy-DD-MM').format(today))
      title = "Today's Agenda";
    else if (DateFormat('yyyy-DD-MM').format(currentDate) == DateFormat('yyyy-DD-MM').format(tomorrow))
      title = "Tomorrow's Agenda";
    else
      title = DateFormat.yMMMd().format(currentDate);

    return Positioned(
      top: MediaQuery.of(context).viewPadding.top + 10,
      left: 10,
      child: Row(
        children: <Widget>[
          NeumorphicButton(
            onPressed: onPressed,
            style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.concave),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.menu,
                  color: NeumorphicTheme.of(context).current.accentColor,
                  size: 26,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
