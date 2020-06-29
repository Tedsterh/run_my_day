part of 'active_activities_bloc.dart';

abstract class ActiveActivitiesEvent extends Equatable {
  const ActiveActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetActiveActivities extends ActiveActivitiesEvent {
  final DateTime currentDate;

  GetActiveActivities(this.currentDate);

  @override
  List<Object> get props => [currentDate];
}

class ActiveActivitiesUpdated extends ActiveActivitiesEvent {
  final List<ActivityModel> activities;

  ActiveActivitiesUpdated(this.activities);

  @override
  List<Object> get props => [activities];
}

class EndEarly extends ActiveActivitiesEvent {
  final String activityID;

  EndEarly(this.activityID);

  @override
  List<Object> get props => [activityID];
}
