
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    Key key,
    @required this.currentUserModel,
  }) : super(key: key);

  final CurrentUserModel currentUserModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                color: Color(0xFF7D9DFD),
                shadowLightColor: Color(0xFFA5BAFA)
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: Image.network(
                    currentUserModel.profilePhoto
                  ).image
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NeumorphicText(
                  currentUserModel.name,
                  style: NeumorphicStyle(
                    shadowLightColor: Color(0xFFD4DFFF),
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.dosis().fontFamily
                  ),
                ),
                SizedBox(
                  height: 5
                ),
                NeumorphicText(
                  currentUserModel.email,
                  style: NeumorphicStyle(
                    shadowLightColor: Color(0xFFD4DFFF),
                    color: Color(0xFFDDE5FD)
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 13,
                    fontFamily: GoogleFonts.dosis().fontFamily
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}