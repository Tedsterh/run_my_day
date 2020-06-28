import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class TomorrowsAgendaTile extends StatelessWidget {
  const TomorrowsAgendaTile({
    Key key,
    @required this.onPressed
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: NeumorphicIcon(
        FontAwesome.calendar_plus_o,
        size: 30,
        style: NeumorphicStyle(
          shadowLightColor: Color(0xFFD4DFFF),
        ),
      ),
      title: NeumorphicText(
        'Tomorrow\'s Agenda',
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