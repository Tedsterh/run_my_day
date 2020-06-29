import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/active_activities_builder.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/activity_list_builder.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/completed_activities_widgets/completed_activities_list_builder.dart';
import 'package:run_my_lockdown/pages/home_page/weather_widgets/weather_forecast_page.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_item.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/calender_item_dialog_box.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.openDrawer, @required this.currentLookingAt}) : super(key: key);
  final VoidCallback openDrawer;
  final DateTime currentLookingAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.of(context).current.baseColor,
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).viewPadding.top,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).viewPadding.top),
              left: 0,
              child: ListView(
                children: <Widget>[
                  WeatherForcastTile(),
                  ActiveActivityListBuilder(
                    currentLookingAt: currentLookingAt
                  ),
                  ActivityListBuilder(
                    currentLookingAt: currentLookingAt
                  ),
                  CompletedActivityListBuilder(
                    currentLookingAt: currentLookingAt
                  )
                ],
              ),
            ),
            CustomAppBar(
              onPressed: () => openDrawer(),
              currentDate: currentLookingAt,
            ),
            AddCalenderItem(
              onAdd: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext builderContext) {
                      return CalenderItemDialogBox(
                        reset: () {
                          Navigator.of(context).pop();
                        },
                        addActivity: (activityModel) {
                          BlocProvider.of<ActivitiesBloc>(context)
                              .add(AddNewEvent(activityModel));
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
