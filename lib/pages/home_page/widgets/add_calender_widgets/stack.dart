import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/event_description.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/event_name.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/event_predefined_actions.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/event/popup_actions.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/image/choose_image_widget.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/time_widget/time_widget.dart';

class StackWidget extends StatefulWidget {
  StackWidget({Key key, @required this.reset, @required this.addActivity})
      : super(key: key);
  final VoidCallback reset;
  final Function(ActivityModel) addActivity;

  @override
  _StackWidgetState createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
  ValueNotifier<Duration> duration = ValueNotifier(Duration(minutes: 30));
  ValueNotifier<String> eventTitle = ValueNotifier('');
  ValueNotifier<String> descriptions = ValueNotifier('');
  ValueNotifier<String> icon = ValueNotifier('');
  final ValueNotifier<String> movieID = ValueNotifier(null);
  final ValueNotifier<LatLng> eventLocation = ValueNotifier(null);
  final ValueNotifier<List<String>> actionList = ValueNotifier([]);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Container(
              height: 680,
              child: Stack(
                children: <Widget>[
                  ChooseIconWidget(icon: icon),
                  Positioned(
                    top: 20,
                    left: 15,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        EventTextField(descriptions: eventTitle),
                        SizedBox(height: 15),
                        SelectTimeTile(duration: duration),
                        SizedBox(height: 15),
                        EventDescriptionField(descriptions: descriptions),
                        AddPredefinedActions(
                          scrollController: _scrollController,
                          actionList: actionList,
                          eventLocation: eventLocation,
                          movieID: movieID,
                          duration: duration,
                        ),
                        EventActionsAdd(
                          onAdd: () {
                            widget.reset();
                            widget.addActivity(ActivityModel(
                                duration: duration.value,
                                iconName: icon.value,
                                description: descriptions.value,
                                eventActions: actionList.value,
                                eventName: eventTitle.value,
                                eventLocation: eventLocation.value,
                                movieID: movieID.value));
                          },
                          reset: widget.reset,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
