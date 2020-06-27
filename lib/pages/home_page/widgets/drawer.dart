import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/profile_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/sign_out_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/todays_agenda.dart';

class SlidingDrawer extends StatelessWidget {
  final CurrentUserModel currentUserModel;

  const SlidingDrawer({Key key, @required this.currentUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Material(
        color: Color(0xFF7D9DFD),
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                UserProfileTile(currentUserModel: currentUserModel),
                TodaysAgendaTile(
                  onPressed: () {},
                ),
                Spacer(),
                SignOutDrawerTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}