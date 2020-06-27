import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EventDescriptionField extends StatelessWidget {
  const EventDescriptionField({
    Key key,
    @required this.descriptions,
  }) : super(key: key);

  final ValueNotifier<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Event Description',
          style: TextStyle(
            fontSize: 20
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            depth: -30
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.16,
            child: Center(
              child: ValueListenableBuilder<String>(
                valueListenable: descriptions,
                builder: (context, description, child) {
                  return TextFormField(
                    cursorColor: Color(0xFF7D9DFD),
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    minLines: 3,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: description != '' ? description : 'Enter event description',
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
        ),
      ],
    );
  }
}
