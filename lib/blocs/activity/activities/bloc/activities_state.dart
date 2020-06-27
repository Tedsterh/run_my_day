part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

class LoadingActivities extends ActivitiesState {}

class UpdatedActivities extends ActivitiesState {
  final List<ActivityModel> activities;

  UpdatedActivities(this.activities);

  @override
  List<Object> get props => [activities];

  @override
  String toString() => 'UpdatedActivities { activities: $activities }';
}
