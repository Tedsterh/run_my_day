import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

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
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30))
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  height: 30,
                  left: 10,
                  child: Container(
                    child: Image.asset(
                      'assets/google_logo/g-logo.png'
                    ),
                  )
                ),
                Center(
                  child: Text(
                    'Sign In With Google',
                    style: TextStyle(
                      fontFamily: GoogleFonts.dosis().fontFamily,
                      color: Colors.black,
                      fontSize: 16
                    ),
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