import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class TodaysAgendaTile extends StatelessWidget {
  const TodaysAgendaTile({
    Key key,
    @required this.onPressed
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: NeumorphicIcon(
        Icons.calendar_today,
        size: 30,
        style: NeumorphicStyle(
          shadowLightColor: Color(0xFFD4DFFF),
        ),
      ),
      title: NeumorphicText(
        'Today\'s Agenda',
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