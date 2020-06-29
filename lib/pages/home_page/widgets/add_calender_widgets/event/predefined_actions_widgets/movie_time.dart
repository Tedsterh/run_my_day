import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/predefined_actions_widgets/movie/movie_choose_popup.dart';

class MovieTimeAction extends StatelessWidget {
  const MovieTimeAction(
      {Key key,
      @required this.actionList,
      @required this.movieID,
      @required this.duration})
      : super(key: key);
  final ValueNotifier<List<String>> actionList;
  final ValueNotifier<String> movieID;
  final ValueNotifier<Duration> duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
      child: ListTile(
        leading: ValueListenableBuilder<List<String>>(
            valueListenable: actionList,
            builder: (context, list, child) {
              return NeumorphicCheckbox(
                  value: list.contains('movieTime'),
                  onChanged: (value) async {
                    if (value) {
                      List newList = List<String>.from(actionList.value);
                      newList.add('movieTime');
                      actionList.value = newList;
                      List _movieID = await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return MovieTimePopup.create(context);
                          });
                      movieID.value = _movieID[0].toString();
                    } else {
                      List newList = List<String>.from(actionList.value);
                      newList.remove('movieTime');
                      actionList.value = newList;
                      movieID.value = null;
                    }
                  });
            }),
        title: Text('Movie To Watch'),
      ),
    );
  }
}
