part of 'active_activities_bloc.dart';

abstract class ActiveActivitiesEvent extends Equatable {
  const ActiveActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetActiveActivities extends ActiveActivitiesEvent {}

class ActiveActivitiesUpdated extends ActiveActivitiesEvent {
  final List<ActivityModel> activities;

  ActiveActivitiesUpdated(this.activities);

  @override
  List<Object> get props => [activities];
}
