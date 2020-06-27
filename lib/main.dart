import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_my_lockdown/blocs/auth/authentication/bloc/authentication_bloc.dart';
import 'package:run_my_lockdown/blocs/simple_bloc_delegate.dart';
import 'package:run_my_lockdown/pages/home_page/home_page_builder.dart';
import 'package:run_my_lockdown/pages/sign_in_page/sign_in_page.dart';
import 'package:run_my_lockdown/pages/splash_screen/splash_screen.dart';
import 'package:run_my_lockdown/repositories/user_repository/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted()),
      child: RunMyLockdownApp(
        userRepository: userRepository,
      ),
    )
  );
}

class RunMyLockdownApp extends StatelessWidget {
  final UserRepository _userRepository;

  const RunMyLockdownApp({@required UserRepository userRepository})
    : assert(userRepository != null),
      _userRepository = userRepository;

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
        intensity: 1.0,
        depth: 10,
        textTheme: GoogleFonts.dosisTextTheme(
          TextTheme(
            headline5: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            headline4: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            bodyText1: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            bodyText2: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            subtitle1: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            subtitle2: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
          ),
        )
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        accentColor: Color(0xFF7D9DFD),
        intensity: 0.3,
        depth: 4,
        textTheme: GoogleFonts.dosisTextTheme(
          TextTheme(
            headline5: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            headline4: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            bodyText1: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            bodyText2: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            subtitle1: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
            subtitle2: TextStyle(
              color: Color(0xFF7D9DFD)
            ),
          ),
        )
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return SignInPage.create(context, userRepository: _userRepository);
          }
          if (state is Uninisialised) {
            return SplashScreen();
          }
          if (state is Authenticated) {
            return HomePageBuilder(
              currentUserModel: state.currentUser,
            );
          }
          return SplashScreen();
        }
      ),
    );
  }
}
