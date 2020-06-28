import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/next_week_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/profile_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/sign_out_tile.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/todays_agenda.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/drawer_widgets/tomorrows_agenda.dart';

class SlidingDrawer extends StatelessWidget {
  final CurrentUserModel currentUserModel;
  final VoidCallback closeDrawer;
  final Function(DateTime) changeDate;

  const SlidingDrawer(
      {Key key,
      @required this.currentUserModel,
      @required this.closeDrawer,
      @required this.changeDate})
      : super(key: key);

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
                  onPressed: () {
                    closeDrawer();
                    changeDate(DateTime.now());
                  },
                ),
                TomorrowsAgendaTile(onPressed: () {
                  closeDrawer();
                  changeDate(DateTime.now().add(Duration(days: 1)));
                }),
                NextMondaysAgendaTile(onPressed: () {
                  closeDrawer();
                  var now = DateTime.now();
                  changeDate(now.add(Duration(days: 7 - (now.weekday - 1))));
                }),
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
