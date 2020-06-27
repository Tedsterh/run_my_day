import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_item.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/calender_item_dialog_box.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.openDrawer}) : super(key: key);
  final VoidCallback openDrawer;

  static Widget create(context, {@required VoidCallback openDrawer}) {
    return HomePage(
      openDrawer: openDrawer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.of(context).current.baseColor,
      body: Center(
        child: Stack(
          children: <Widget>[
            CustomAppBar(
              title: 'Agenda',
              onPressed: () => openDrawer(),
            ),
            AddCalenderItem(
              onAdd: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return CalenderItemDialogBox(
                      reset: () {
                        Navigator.of(context).pop();
                      },
                      addActivity: (activityModel) {
                        
                      },
                    );
                  }
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
