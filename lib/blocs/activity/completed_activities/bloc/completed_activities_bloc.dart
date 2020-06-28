import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/repositories/activities_repository/activities_repository.dart';

part 'completed_activities_event.dart';
part 'completed_activities_state.dart';

class CompletedActivitiesBloc
    extends Bloc<CompletedActivitiesEvent, CompletedActivitiesState> {
  final ActivitiesRepository _activitiesRepository;
  StreamSubscription _activitiesSubscription;

  CompletedActivitiesBloc({@required ActivitiesRepository activitiesRepository})
      : assert(activitiesRepository != null),
        _activitiesRepository = activitiesRepository;

  @override
  CompletedActivitiesState get initialState => LoadingCompletedActivities();

  @override
  Future<void> close() {
    _activitiesSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<CompletedActivitiesState> mapEventToState(
    CompletedActivitiesEvent event,
  ) async* {
    if (event is GetCompletedActivities) {
      yield* _mapGetCompletedActivitiesToState(event);
    } else if (event is CompletedActivitiesUpdated) {
      yield* _mapCompletedActivitiesUpdatedToState(event);
    } else if (event is AddToTomorrow) {
      yield* _mapAddToTomorrowToState(event);
    }
  }

  Stream<CompletedActivitiesState> _mapGetCompletedActivitiesToState(
      GetCompletedActivities event) async* {
    _activitiesSubscription?.cancel();
    _activitiesSubscription = _activitiesRepository
        .getCompletedActivities(currentDate: event.currentDate)
        .listen((activities) {
      add(CompletedActivitiesUpdated(activities));
    });
  }

  Stream<CompletedActivitiesState> _mapCompletedActivitiesUpdatedToState(
      CompletedActivitiesUpdated event) async* {
    yield UpdatedCompletedActivities(event.activities);
  }

  Stream<CompletedActivitiesState> _mapAddToTomorrowToState(
      AddToTomorrow event) async* {
    _activitiesRepository.addAgainTomorrow(
        activityID: event.activityID, currentDate: DateTime.now());
  }
}
