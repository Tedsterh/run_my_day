import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SelectTimeTile extends StatefulWidget {
  SelectTimeTile({
    Key key,
    @required this.duration,
  }) : super(key: key);

  final ValueNotifier<Duration> duration;

  @override
  _SelectTimeTileState createState() => _SelectTimeTileState();
}

class _SelectTimeTileState extends State<SelectTimeTile> {
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes M";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Select Time',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Neumorphic(
              style: NeumorphicStyle(depth: -30),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  Duration resultingDuration = await showDurationPicker(
                    context: context,
                    initialTime: widget.duration.value,
                    snapToMins: 1.0
                  );
                  widget.duration.value = resultingDuration;
                },
                child: ValueListenableBuilder<Duration>(
                    valueListenable: widget.duration,
                    builder: (context, duration, child) {
                      return Container(
                        height: 40,
                        width:
                            ((MediaQuery.of(context).size.width / 1.16) / 2) -
                                10,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 10),
                              Text(
                                duration != null
                                    ? _printDuration(duration)
                                    : 'Start time',
                                textAlign: TextAlign.start,
                              ),
                              Spacer(),
                              Icon(
                                Icons.calendar_today,
                                color: Color(0xFF7D9DFD),
                              ),
                              SizedBox(width: 10)
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
