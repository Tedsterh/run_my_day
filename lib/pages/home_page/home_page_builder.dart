import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:run_my_lockdown/blocs/activity/active_activities/bloc/active_activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/completed_activities/bloc/completed_activities_bloc.dart';
import 'package:run_my_lockdown/main.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/pages/home_page/home_page.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_drawer_builder.dart';
import 'package:run_my_lockdown/repositories/activities_repository/implementations/firebase_activities_repository.dart';
import 'package:run_my_lockdown/repositories/notification_repository/notification_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageBuilder extends StatefulWidget {
  final CurrentUserModel currentUserModel;
  final NotificationRepository notificationRepository;

  HomePageBuilder(
      {Key key,
      @required this.currentUserModel,
      @required this.notificationRepository})
      : super(key: key);

  static Widget create(context,
      {@required String uid,
      @required DateTime currentDate,
      @required CurrentUserModel currentUserModel,
      @required NotificationRepository notificationRepository}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivitiesBloc>(
            create: (context) => ActivitiesBloc(
                activitiesRepository: FirebaseActivitiesRepository(uid),
                notificationRepository: notificationRepository)
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
        notificationRepository: notificationRepository,
      ),
    );
  }

  @override
  _HomePageBuilderState createState() => _HomePageBuilderState();
}

class _HomePageBuilderState extends State<HomePageBuilder> {
  ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    setupDailyNotificationsPopup(
        context: context,
        notificationRepository: widget.notificationRepository);
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            //TODO:
          });
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SecondScreen(payload)),
      // );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

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
      currentUserModel: widget.currentUserModel,
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

Future<void> setupDailyNotificationsPopup(
    {@required BuildContext context,
    @required NotificationRepository notificationRepository}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('completedSetupNotification') == null ||
      !prefs.getBool('completedSetupNotification')) {
    DateTime date = await showDialog(
        context: context,
        builder: (BuildContext context) {
          DateTime time;
          ValueNotifier<TimeOfDay> chosenTime = ValueNotifier(TimeOfDay.now());
          return Center(
              child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Text(
              'Setup Daily Notifications',
              style: Theme.of(context).textTheme.headline4,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Tap the button below to setup a daily reminder, this will help you setup a routine and keep your day moving.',
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
                FlatButton(
                    onPressed: () async {
                      var _time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      chosenTime.value = _time;
                      time = DateTime(1969, 1, 1, _time.hour, _time.minute, 0);
                    },
                    child: Text(
                      'Tap to select time',
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(height: 10),
                ValueListenableBuilder<TimeOfDay>(
                    valueListenable: chosenTime,
                    builder: (context, timeOfDay, child) {
                      return Text(
                          'Notifications will display everyday at: ${timeOfDay.hour}:${timeOfDay.minute}.',
                          textAlign: TextAlign.center);
                    }),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(time);
                  },
                  child: Text('Ok'))
            ],
          ));
        });
    notificationRepository.setupDailyNotification(dateTime: date);
    prefs.setBool('completedSetupNotification', true);
  }
}
