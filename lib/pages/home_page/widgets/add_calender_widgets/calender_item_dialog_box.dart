import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:run_my_lockdown/blocs/activity/icon/bloc/icon_bloc.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/pages/home_page/widgets/add_calender_widgets/stack.dart';

class CalenderItemDialogBox extends StatelessWidget {
  const CalenderItemDialogBox({Key key, @required this.addActivity, @required this.reset}) : super(key: key);
  final VoidCallback reset;
  final Function(ActivityModel) addActivity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            var width = MediaQuery.of(context).size.width;
            return Container(
              child: BlocProvider<IconBloc>(
                create: (context) => IconBloc(),
                child: Hero(
                  tag: 'addCalenderItem',
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Container(
                      width: width - 25,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: StackWidget(
                        reset: reset,
                        addActivity: addActivity,
                      )
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}