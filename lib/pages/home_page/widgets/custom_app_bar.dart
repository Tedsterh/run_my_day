
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key, this.onPressed, this.title,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).viewPadding.top + 10,
      left: 10,
      child: Row(
        children: <Widget>[
          NeumorphicButton(
            onPressed: onPressed,
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.concave
            ),
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