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
  ActivitiesState get initialState => LoadingActivities();

  @override
  Future<void> close() {
    _activitiesSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ActivitiesState> mapEventToState(ActivitiesEvent event) async* {
    if (event is GetActivities) {
      yield* _mapGetActivitiesToState(event);
    } else if (event is ActivitiesUpdated) {
      yield* _mapActivitiesUpdatedToState(event);
    } else if (event is AddNewEvent) {
      yield* _mapAddNewEventToState(event);
    }
  }

  Stream<ActivitiesState> _mapGetActivitiesToState(GetActivities event) async* {
    _activitiesSubscription?.cancel();
    _activitiesSubscription = _activitiesRepository
        .getActivities(currentDate: DateTime.now())
        .listen((activities) {
      add(ActivitiesUpdated(activities));
    });
  }

  Stream<ActivitiesState> _mapActivitiesUpdatedToState(
      ActivitiesUpdated event) async* {
    yield UpdatedActivities(event.activities);
  }

  Stream<ActivitiesState> _mapAddNewEventToState(AddNewEvent event) async* {
    var uuid = Uuid();
    _activitiesRepository.addNewActivity(
        activityModel: event.activity.copyWith(eventID: uuid.v4()),
        currentDate: DateTime.now());
  }
}
