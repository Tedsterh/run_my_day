import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_my_lockdown/blocs/auth/authentication/bloc/authentication_bloc.dart';
import 'package:run_my_lockdown/platform_specific_widgets/platform_aler_dialog.dart';

class SignOutDrawerTile extends StatelessWidget {
  const SignOutDrawerTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        bool shouldSignOut = await PlatformAlertDialog(
          title: 'Sign Out', 
          content: 'Are you sure you want to sign out?', 
          defaultActionText: 'Yes',
          cancelActionText: 'No',
        ).show(context);
        if (shouldSignOut) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        }
      },
      leading: NeumorphicIcon(
        Icons.exit_to_app,
        size: 30,
        style: NeumorphicStyle(
          shadowLightColor: Color(0xFFD4DFFF),
        ),
      ),
      title: NeumorphicText(
        'Sign Out',
        textAlign: TextAlign.start,
        style: NeumorphicStyle(
          shadowLightColor: Color(0xFFD4DFFF),
        ),
        textStyle: NeumorphicTextStyle(
          fontSize: 18,
          fontFamily: GoogleFonts.dosis().fontFamily
        ),
      ),
    );
  }
}