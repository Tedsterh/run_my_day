part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableActivities extends ActivitiesEvent {}

class AvailableActivitiesUpdated extends ActivitiesEvent {
  final List<ActivityModel> activities;

  AvailableActivitiesUpdated(this.activities);

  @override
  List<Object> get props => [activities];
}

class AddNewEvent extends ActivitiesEvent {
  final ActivityModel activity;

  AddNewEvent(this.activity);

  @override
  List<Object> get props => [activity];
}

class StartNow extends ActivitiesEvent {
  final ActivityModel activityModel;

  StartNow(this.activityModel);

  @override
  List<Object> get props => [activityModel];
}

class StartInAnHour extends ActivitiesEvent {
  final ActivityModel activityModel;

  StartInAnHour(this.activityModel);

  @override
  List<Object> get props => [activityModel];
}

class DefereTillTomorrow extends ActivitiesEvent {
  final ActivityModel activityModel;

  DefereTillTomorrow(this.activityModel);

  @override
  List<Object> get props => [activityModel];
}