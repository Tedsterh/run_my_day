import 'package:flutter/material.dart';
import 'package:run_my_lockdown/models/models/current_user_model/current_user_model.dart';
import 'package:run_my_lockdown/pages/home_page/home_page.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_drawer_builder.dart';

class HomePageBuilder extends StatelessWidget {
  final CurrentUserModel currentUserModel;

  const HomePageBuilder({Key key, @required this.currentUserModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Builder(
      builder: (context) {
        return HomePage.create(
          context,
          openDrawer: () => SlidingMenuDrawer.of(context).toggle()
        );
      }
    );
    child = SlidingMenuDrawer(child: child, currentUserModel: currentUserModel,);
    return child;
  }
}