import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_my_lockdown/blocs/auth/authentication/bloc/authentication_bloc.dart';
import 'package:run_my_lockdown/blocs/simple_bloc_delegate.dart';
import 'package:run_my_lockdown/pages/home_page/home_page_builder.dart';
import 'package:run_my_lockdown/pages/sign_in_page/sign_in_page.dart';
import 'package:run_my_lockdown/pages/splash_screen/splash_screen.dart';
import 'package:run_my_lockdown/repositories/notification_repository/notification_repository.dart';
import 'package:run_my_lockdown/repositories/user_repository/user_repository.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
    didReceiveLocalNotificationSubject.add(ReceivedNotification(
        id: id, title: title, body: body, payload: payload));
  });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final NotificationRepository notificationRepository =
      NotificationRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: RunMyLockdownApp(
      userRepository: userRepository,
      notificationRepository: notificationRepository,
    ),
  ));
}

class RunMyLockdownApp extends StatefulWidget {
  final UserRepository _userRepository;
  final NotificationRepository _notificationRepository;

  const RunMyLockdownApp(
      {@required UserRepository userRepository,
      @required NotificationRepository notificationRepository})
      : assert(userRepository != null && notificationRepository != null),
        _userRepository = userRepository,
        _notificationRepository = notificationRepository;

  @override
  _RunMyLockdownAppState createState() => _RunMyLockdownAppState();
}

class _RunMyLockdownAppState extends State<RunMyLockdownApp> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic App',
      themeMode: ThemeMode.system,
      theme: NeumorphicThemeData(
          baseColor: Color(0xFFFFFFFF),
          lightSource: LightSource.topLeft,
          accentColor: Color(0xFF7D9DFD),
          intensity: 0.7,
          depth: 10,
          textTheme: GoogleFonts.dosisTextTheme(
            TextTheme(
              headline5: TextStyle(color: Color(0xFF7D9DFD)),
              headline4: TextStyle(color: Color(0xFF7D9DFD)),
              bodyText1: TextStyle(color: Color(0xFF7D9DFD)),
              bodyText2: TextStyle(color: Color(0xFF7D9DFD)),
              subtitle1: TextStyle(color: Color(0xFF7D9DFD)),
              subtitle2: TextStyle(color: Color(0xFF7D9DFD)),
            ),
          )),
      darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          accentColor: Color(0xFF7D9DFD),
          intensity: 0.3,
          depth: 4,
          textTheme: GoogleFonts.dosisTextTheme(
            TextTheme(
              headline5: TextStyle(color: Color(0xFF7D9DFD)),
              headline4: TextStyle(color: Color(0xFF7D9DFD)),
              bodyText1: TextStyle(color: Color(0xFF7D9DFD)),
              bodyText2: TextStyle(color: Color(0xFF7D9DFD)),
              subtitle1: TextStyle(color: Color(0xFF7D9DFD)),
              subtitle2: TextStyle(color: Color(0xFF7D9DFD)),
            ),
          )),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is Unauthenticated) {
          return SignInPage.create(context,
              userRepository: widget._userRepository);
        }
        if (state is Uninisialised) {
          return SplashScreen();
        }
        if (state is Authenticated) {
          return HomePageBuilder.create(context,
              uid: state.currentUser.userID,
              currentUserModel: state.currentUser,
              currentDate: DateTime.now(),
              notificationRepository: widget._notificationRepository);
        }
        return SplashScreen();
      }),
    );
  }
}
