part of 'active_activities_bloc.dart';

abstract class ActiveActivitiesState extends Equatable {
  const ActiveActivitiesState();

  @override
  List<Object> get props => [];
}

class LoadingActiveActivities extends ActiveActivitiesState {}

class UpdatedActiveActivities extends ActiveActivitiesState {
  final List<ActivityModel> activities;

  UpdatedActiveActivities(this.activities);

  @override
  List<Object> get props => [activities];
}
