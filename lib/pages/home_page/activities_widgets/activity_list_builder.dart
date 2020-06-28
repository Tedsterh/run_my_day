import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_my_lockdown/blocs/activity/activities/bloc/activities_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/activities_widgets/activities_card.dart';

class ActivityListBuilder extends StatelessWidget {
  const ActivityListBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).viewPadding.top,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).viewPadding.top),
      left: 0,
      child: BlocBuilder<ActivitiesBloc, ActivitiesState>(
          builder: (context, state) {
        return Container(
          color: Colors.transparent,
          child: state is UpdatedActivities
              ? ListView.builder(
                  itemCount: state.activities.length + 1,
                  itemBuilder: (BuildContext context, index) {
                    if (index != 0) {
                      return ActivityCard(
                          activityModel: state.activities[index - 1]);
                    }
                    return SizedBox(height: 50,);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      }),
    );
  }
}
