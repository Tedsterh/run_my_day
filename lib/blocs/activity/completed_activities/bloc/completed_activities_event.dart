part of 'completed_activities_bloc.dart';

abstract class CompletedActivitiesEvent extends Equatable {
  const CompletedActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetCompletedActivities extends CompletedActivitiesEvent {
  final DateTime currentDate;

  GetCompletedActivities(this.currentDate);

  @override
  List<Object> get props => [currentDate];
}

class CompletedActivitiesUpdated extends CompletedActivitiesEvent {
  final List<ActivityModel> activities;

  CompletedActivitiesUpdated(this.activities);

  @override
  List<Object> get props => [activities];
}

class AddToTomorrow extends CompletedActivitiesEvent {
  final String activityID;

  AddToTomorrow(this.activityID);

  @override
  List<Object> get props => [activityID];
}
