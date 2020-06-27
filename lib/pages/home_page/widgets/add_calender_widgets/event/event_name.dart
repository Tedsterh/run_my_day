
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EventTextField extends StatelessWidget {
  const EventTextField({
    Key key,
    @required this.descriptions,
  }) : super(key: key);

  final ValueNotifier<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -30
      ),
      child: Container(
        height: 45,
        width: 250,
        child: Center(
          child: ValueListenableBuilder<String>(
            valueListenable: descriptions,
            builder: (context, description, child) {
              return TextFormField(
                cursorColor: Color(0xFF7D9DFD),
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: description != '' ? description : 'Event name',
                  hintStyle: TextStyle(
                    color: Color(0xFF7D9DFD)
                  )
                ),
                onChanged: (value) {
                  descriptions.value = value;
                },
              );
            }
          ),
        ),
      ),
    );
  }
}