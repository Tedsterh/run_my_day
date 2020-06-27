import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/auth/authentication/bloc/authentication_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static Widget create(context) {
    return HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.of(context).current.baseColor,
      body: Stack(
        children: <Widget>[
          CustomAppBar(
            title: 'Agenda',
            onPressed: () {

            },
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              child: Text(
                'sign out'
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewPadding.bottom,
            right: 20,
            child: NeumorphicButton(
              onPressed: () {
                
              },
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.convex
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.add,
                    color: NeumorphicTheme.of(context).current.accentColor,
                    size: 35,
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}