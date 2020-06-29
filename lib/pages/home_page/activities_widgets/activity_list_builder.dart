import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/activities_card.dart';

class ActivityListBuilder extends StatelessWidget {
  const ActivityListBuilder({Key key, @required this.currentLookingAt})
      : super(key: key);

  final DateTime currentLookingAt;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesBloc, ActivitiesState>(
        builder: (context, state) {
      return Container(
        color: Colors.transparent,
        child: state is UpdatedAvailableActivities
            ? ListView.builder(
                itemCount: state.activities.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  if (index != 0) {
                    return AvailableActivityCard(
                        currentLookingAt: currentLookingAt,
                        activityModel: state.activities[index - 1]);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 30),
                          Text(
                            'Available Activities',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}
