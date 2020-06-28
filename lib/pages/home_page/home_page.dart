import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity/active_activities/bloc/active_activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/completed_activities/bloc/completed_activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/active_activities_builder.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/activity_list_builder.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/completed_activities_widgets/completed_activities_list_builder.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_item.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/calender_item_dialog_box.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_app_bar.dart';
import 'package:run_my_lockdown/repositories/activities_repository/implementations/firebase_activities_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.openDrawer}) : super(key: key);
  final VoidCallback openDrawer;

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
                  ActivityListBuilder(),
                  ActiveActivityListBuilder(),
                  CompletedActivityListBuilder()
                ],
              ),
            ),
            CustomAppBar(
              title: 'Todays Agenda',
              onPressed: () => openDrawer(),
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
