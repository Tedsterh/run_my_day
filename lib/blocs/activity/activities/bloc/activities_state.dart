part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

class LoadingAvailableActivities extends ActivitiesState {}

class UpdatedAvailableActivities extends ActivitiesState {
  final List<ActivityModel> activities;

  UpdatedAvailableActivities(this.activities);

  @override
  List<Object> get props => [activities];

  @override
  String toString() => 'UpdatedActivities { activities: $activities }';
}
