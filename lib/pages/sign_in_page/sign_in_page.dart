import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/auth/authentication/bloc/authentication_bloc.dart';
import 'package:run_my_lockdown/blocs/auth/login/bloc/login_bloc.dart';
import 'package:run_my_lockdown/pages/sign_in_page/widgets/sign_in_with_google.dart';
import 'package:run_my_lockdown/repositories/user_repository/user_repository.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  static Widget create(context, {@required UserRepository userRepository}) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: SignInPage(),
    );
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  CancelFunc _cancelFunc;

  Color get primaryColor => NeumorphicTheme.of(context).current.baseColor;
  Color get accentColor => NeumorphicTheme.of(context).current.accentColor;
  Color get backgroundColor => NeumorphicTheme.of(context).current.baseColor;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccess) {
          _cancelFunc();
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        if (state is LoginLoading) {
          _cancelFunc = BotToast.showLoading();
        }
        if (state is LoginFailed) {
          BotToast.showText(text: 'Login Failed');
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Text(
            'Sign In',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: NeumorphicText(
                  'Welcome to Run My Lockdown\n to get started sign in with Google below',
                  textAlign: TextAlign.center,
                  style: NeumorphicStyle(
                    color: Colors.black,
                    shadowLightColor: Color(0xFF7D9DFD)
                  ),
                ),
              ),
              SizedBox(height: 40),
              SignInGoogleButton(
                signInWithGoogle: _signInWithGoogle,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithGoogle() {
    BlocProvider.of<LoginBloc>(context).add(SignInWithGoogle());
  }
}
