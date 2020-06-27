part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetActivities extends ActivitiesEvent {}

class ActivitiesUpdated extends ActivitiesEvent {
  final List<ActivityModel> activities;

  ActivitiesUpdated(this.activities);

  @override
  List<Object> get props => [activities];
}

class AddNewEvent extends ActivitiesEvent {
  final ActivityModel activity;

  AddNewEvent(this.activity);

  @override
  List<Object> get props => [activity];
}
