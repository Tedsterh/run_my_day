import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/repositories/activities_repository/activities_repository.dart';

part 'active_activities_event.dart';
part 'active_activities_state.dart';

class ActiveActivitiesBloc
    extends Bloc<ActiveActivitiesEvent, ActiveActivitiesState> {
  final ActivitiesRepository _activitiesRepository;
  StreamSubscription _activitySubscription;

  ActiveActivitiesBloc({@required ActivitiesRepository activitiesRepository})
      : assert(activitiesRepository != null),
        _activitiesRepository = activitiesRepository;

  @override
  ActiveActivitiesState get initialState => LoadingActiveActivities();

  @override
  Future<void> close() {
    _activitySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ActiveActivitiesState> mapEventToState(
    ActiveActivitiesEvent event,
  ) async* {
    if (event is GetActiveActivities) {
      yield* _mapGetActiveActivitiesToState(event);
    } else if (event is ActiveActivitiesUpdated) {
      yield* _mapActiveActivitiesUpdatedToState(event);
    } else if (event is EndEarly) {
      yield* _mapEndEarlyToState(event);
    }
  }

  Stream<ActiveActivitiesState> _mapGetActiveActivitiesToState(
      GetActiveActivities event) async* {
    _activitySubscription?.cancel();
    _activitySubscription = _activitiesRepository
        .getCurrentActiveActivities(currentDate: event.currentDate)
        .listen((activities) {
      add(ActiveActivitiesUpdated(activities));
    });
  }

  Stream<ActiveActivitiesState> _mapActiveActivitiesUpdatedToState(
      ActiveActivitiesUpdated event) async* {
    yield UpdatedActiveActivities(event.activities);
  }

  Stream<ActiveActivitiesState> _mapEndEarlyToState(EndEarly event) async* {
    _activitiesRepository.endEarly(
        activityID: event.activityID, endTime: DateTime.now().subtract(Duration(minutes: 4)));
  }
}
