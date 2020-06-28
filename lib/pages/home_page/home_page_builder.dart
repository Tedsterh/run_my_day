import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/active_activities/bloc/active_activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/completed_activities/bloc/completed_activities_bloc.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/pages/home_page/home_page.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_drawer_builder.dart';
import 'package:run_my_lockdown/repositories/activities_repository/implementations/firebase_activities_repository.dart';

class HomePageBuilder extends StatelessWidget {
  final CurrentUserModel currentUserModel;

  HomePageBuilder({Key key, @required this.currentUserModel})
      : super(key: key);

  static Widget create(context,
      {@required String uid,
      @required DateTime currentDate,
      @required CurrentUserModel currentUserModel}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivitiesBloc>(
            create: (context) => ActivitiesBloc(
                activitiesRepository: FirebaseActivitiesRepository(uid))
              ..add(GetAvailableActivities(currentDate))),
        BlocProvider<ActiveActivitiesBloc>(
            create: (context) => ActiveActivitiesBloc(
                activitiesRepository: FirebaseActivitiesRepository(uid))
              ..add(GetActiveActivities(currentDate))),
        BlocProvider<CompletedActivitiesBloc>(
            create: (context) => CompletedActivitiesBloc(
                activitiesRepository: FirebaseActivitiesRepository(uid))
              ..add(GetCompletedActivities(currentDate)))
      ],
      child: HomePageBuilder(
        currentUserModel: currentUserModel,
      ),
    );
  }

  ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Widget child = Builder(builder: (context) {
      return ValueListenableBuilder<DateTime>(
          valueListenable: date,
          builder: (context, current, child) {
            return HomePage(
              openDrawer: () => SlidingMenuDrawer.of(context).toggle(),
              currentLookingAt: current,
            );
          });
    });
    child = SlidingMenuDrawer(
      child: child,
      currentUserModel: currentUserModel,
      changeDate: (newDate) {
        BlocProvider.of<ActivitiesBloc>(context)
            .add(GetAvailableActivities(newDate));
        BlocProvider.of<ActiveActivitiesBloc>(context)
            .add(GetActiveActivities(newDate));
        BlocProvider.of<CompletedActivitiesBloc>(context)
            .add(GetCompletedActivities(newDate));
        date.value = newDate;
      },
    );
    return child;
  }
}
