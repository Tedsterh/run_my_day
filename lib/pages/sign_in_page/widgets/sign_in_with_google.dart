import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInGoogleButton extends StatelessWidget {
  const SignInGoogleButton({
    Key key,
    @required this.signInWithGoogle
  }) : super(key: key);

  final VoidCallback signInWithGoogle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.4,
          child: NeumorphicButton(
            onPressed: signInWithGoogle,
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  height: 30,
                  left: 10,
                  child: Icon(
                    FontAwesomeIcons.google
                  )
                ),
                Center(
                  child: Text(
                    'Sign In With Google',
                    style: NeumorphicTheme.of(context).current.textTheme.subtitle1,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}