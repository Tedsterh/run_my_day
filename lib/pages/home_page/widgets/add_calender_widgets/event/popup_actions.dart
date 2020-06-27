import 'package:flutter/material.dart';

class EventActionsAdd extends StatelessWidget {
  const EventActionsAdd({
    Key key,
    @required this.reset,
    @required this.onAdd
  }) : super(key: key);
  final VoidCallback reset;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FlatButton(
            onPressed: reset, 
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF7D9DFD)
              ),
            )
          ),
          FlatButton(
            onPressed: onAdd, 
            child: Text(
              'Add',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF7D9DFD)
              ),
            )
          )
        ],
      ),
    );
  }
}