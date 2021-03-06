import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/active_activities/bloc/active_activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/active_activities_widgets/card_widgets/active_activity_card.dart';

class ActiveActivityListBuilder extends StatelessWidget {
  const ActiveActivityListBuilder({
    Key key,
    @required this.currentLookingAt
  }) : super(key: key);

  final DateTime currentLookingAt;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveActivitiesBloc, ActiveActivitiesState>(
        builder: (context, state) {
      return Container(
        color: Colors.transparent,
        child: state is UpdatedActiveActivities
            ? ListView.builder(
                itemCount: state.activities.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  if (index != 0) {
                    return ActiveActivityCard(
                        activityModel: state.activities[index - 1], currentLookingAt: currentLookingAt);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 30),
                          Text(
                            'Active Activity',
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
