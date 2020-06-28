import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddCalenderItem extends StatelessWidget {
  const AddCalenderItem({
    Key key,
    this.onAdd
  }) : super(key: key);
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewPadding.bottom + 10, 
      right: 20,
      child: Hero(
        tag: 'addCalenderItem',
        child: NeumorphicButton(
          onPressed: onAdd,
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.concave
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.add,
                color: NeumorphicTheme.of(context).current.accentColor,
                size: 35,
              ),
            ),
          ),
        ),
      )
    );
  }
}