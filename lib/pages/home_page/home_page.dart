import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_item.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/calender_item_dialog_box.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_app_bar.dart';
import 'package:run_my_lockdown/repositories/activities_repository/implementations/firebase_activities_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.openDrawer}) : super(key: key);
  final VoidCallback openDrawer;

  static Widget create(context,
      {@required VoidCallback openDrawer, @required String uid}) {
    return BlocProvider<ActivitiesBloc>(
      create: (context) => ActivitiesBloc(
          activitiesRepository: FirebaseActivitiesRepository(uid))
        ..add(GetActivities()),
      child: HomePage(
        openDrawer: openDrawer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.of(context).current.baseColor,
      body: Center(
        child: Stack(
          children: <Widget>[
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
            )
          ],
        ),
      ),
    );
  }
}
