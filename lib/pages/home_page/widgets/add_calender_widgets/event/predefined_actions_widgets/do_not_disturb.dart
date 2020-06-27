import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DoNotDisturbAction extends StatelessWidget {
  const DoNotDisturbAction({Key key, @required this.actionList}) : super(key: key);
  final ValueNotifier<List<String>> actionList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
      child: ListTile(
        leading: ValueListenableBuilder<List<String>>(
          valueListenable: actionList,
          builder: (context, list, child) {
            return NeumorphicCheckbox(
              value: list.contains('doNotDisturb'), 
              onChanged: (value) {
                if (value) {
                  List newList = List<String>.from(actionList.value);
                  newList.add('doNotDisturb');
                  actionList.value = newList;
                } else {
                  List newList = List<String>.from(actionList.value);
                  newList.remove('doNotDisturb');
                  actionList.value = newList;
                }
              }
            );
          }
        ),
        title: Text(
          'Do Not Disturb'
        ),
      ),
    );
  }
}