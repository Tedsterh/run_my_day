part of 'completed_activities_bloc.dart';

abstract class CompletedActivitiesState extends Equatable {
  const CompletedActivitiesState();

  @override
  List<Object> get props => [];
}

class LoadingCompletedActivities extends CompletedActivitiesState {}

class UpdatedCompletedActivities extends CompletedActivitiesState {
  final List<ActivityModel> activities;

  UpdatedCompletedActivities(this.activities);

  @override
  List<Object> get props => [activities];

  @override
  String toString() => 'UpdatedCompletedActivities { UpdatedCompletedActivities: $UpdatedCompletedActivities }';
}
