import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class SelectTimeTile extends StatefulWidget {
  SelectTimeTile({
    Key key,
    @required this.startTime,
    @required this.endTime,
  }) : super(key: key);

  final ValueNotifier<DateTime> startTime;
  final ValueNotifier<DateTime> endTime;

  @override
  _SelectTimeTileState createState() => _SelectTimeTileState();
}

class _SelectTimeTileState extends State<SelectTimeTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Select Time',
          style: TextStyle(
            fontSize: 20
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Neumorphic(
              style: NeumorphicStyle(
                depth: -30
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    widget.startTime.value = DateTimeField.combine(date, time);
                  }
                },
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: widget.startTime,
                  builder: (context, startTime, child) {
                    return Container(
                      height: 40,
                      width: ((MediaQuery.of(context).size.width / 1.16) / 2) - 10,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10
                            ),
                            Text(
                              startTime != null ? DateFormat('yy/MM/dd   hh:mm').format(startTime) : 'Start time',
                              textAlign: TextAlign.start,
                            ),
                            Spacer(),
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF7D9DFD),
                            ),
                            SizedBox(
                              width: 10
                            )
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Neumorphic(
              style: NeumorphicStyle(
                depth: -30
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: widget.startTime.value,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    DateTime newDate = DateTimeField.combine(date, time);
                    if (widget.startTime.value.isBefore(newDate)) {
                      widget.endTime.value = DateTimeField.combine(date, time);
                    }
                  }
                },
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: widget.endTime,
                  builder: (context, endTime, child) {
                    return Container(
                      height: 40,
                      width: ((MediaQuery.of(context).size.width / 1.16) / 2) - 10,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10
                            ),
                            Text(
                              endTime != null ? DateFormat('yy/MM/dd   hh:mm').format(endTime) : 'End time',
                              textAlign: TextAlign.start,
                            ),
                            Spacer(),
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF7D9DFD),
                            ),
                            SizedBox(
                              width: 10
                            )
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}