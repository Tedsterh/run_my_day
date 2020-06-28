import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/models/models/activity_model/activity_model.dart';
import 'package:run_my_lockdown/repositories/activities_repository/activities_repository.dart';
import 'package:uuid/uuid.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final ActivitiesRepository _activitiesRepository;
  StreamSubscription _activitiesSubscription;

  ActivitiesBloc({@required ActivitiesRepository activitiesRepository})
      : assert(activitiesRepository != null),
        _activitiesRepository = activitiesRepository;

  @override
  ActivitiesState get initialState => LoadingAvailableActivities();

  @override
  Future<void> close() {
    _activitiesSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ActivitiesState> mapEventToState(ActivitiesEvent event) async* {
    if (event is GetAvailableActivities) {
      yield* _mapGetActivitiesToState(event);
    } else if (event is AvailableActivitiesUpdated) {
      yield* _mapActivitiesUpdatedToState(event);
    } else if (event is AddNewEvent) {
      yield* _mapAddNewEventToState(event);
    } else if (event is StartNow) {
      yield* _mapStartNowToState(event);
    } else if (event is StartInAnHour) {
      yield* _mapStartInAnHourToState(event);
    } else if (event is DefereTillTomorrow) {
      yield* _mapDefereTillTomorrowToState(event);
    }
  }

  Stream<ActivitiesState> _mapGetActivitiesToState(
      GetAvailableActivities event) async* {
    _activitiesSubscription?.cancel();
    _activitiesSubscription = _activitiesRepository
        .getAvailableActivities(currentDate: event.currentDate)
        .listen((activities) {
      add(AvailableActivitiesUpdated(activities));
    });
  }

  Stream<ActivitiesState> _mapActivitiesUpdatedToState(
      AvailableActivitiesUpdated event) async* {
    yield UpdatedAvailableActivities(event.activities);
  }

  Stream<ActivitiesState> _mapAddNewEventToState(AddNewEvent event) async* {
    var uuid = Uuid();
    _activitiesRepository.addNewActivity(
        activityModel: event.activity.copyWith(eventID: uuid.v4()),
        currentDate: DateTime.now());
  }

  Stream<ActivitiesState> _mapStartNowToState(StartNow event) async* {
    DateTime now = DateTime.now();
    _activitiesRepository.startNow(
        activityID: event.activityModel.eventID,
        startTime: now,
        endTime: now.add(event.activityModel.duration));
  }

  Stream<ActivitiesState> _mapStartInAnHourToState(StartInAnHour event) async* {
    DateTime now = DateTime.now().add(Duration(hours: 1));
    _activitiesRepository.startInAnHour(
        activityID: event.activityModel.eventID,
        startTime: now,
        endTime: now.add(event.activityModel.duration));
  }

  Stream<ActivitiesState> _mapDefereTillTomorrowToState(
      DefereTillTomorrow event) async* {
    DateTime now = DateTime.now().add(Duration(hours: 1));
    _activitiesRepository.defereTillTomorrow(
        activityID: event.activityModel.eventID, currentDate: now);
  }
}
