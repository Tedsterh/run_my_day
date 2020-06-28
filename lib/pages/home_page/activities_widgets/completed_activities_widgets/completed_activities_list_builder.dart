import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/completed_activities/bloc/completed_activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/completed_activities_widgets/completed_activity_card.dart';

class CompletedActivityListBuilder extends StatelessWidget {
  const CompletedActivityListBuilder({
    Key key,
    @required this.currentLookingAt
  }) : super(key: key);

  final DateTime currentLookingAt;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedActivitiesBloc, CompletedActivitiesState>(
        builder: (context, state) {
      return Container(
        color: Colors.transparent,
        child: state is UpdatedCompletedActivities
            ? ListView.builder(
                itemCount: state.activities.length + 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  if (index != 0) {
                    return CompletedActivityCard(
                        activityModel: state.activities[index - 1], currentLookingAt: currentLookingAt);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 30),
                          Text(
                            'Completed Activities',
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
