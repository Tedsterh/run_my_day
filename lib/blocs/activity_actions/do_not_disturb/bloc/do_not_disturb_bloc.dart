import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/repositories/silence_notifications_repository/silence_notifications_repository.dart';

part 'do_not_disturb_event.dart';
part 'do_not_disturb_state.dart';

class DoNotDisturbBloc extends Bloc<DoNotDisturbEvent, DoNotDisturbState> {
  final SilenceNotificationsRepository _notificationsRepository;

  DoNotDisturbBloc(
      {@required SilenceNotificationsRepository notificationsRepository})
      : assert(notificationsRepository != null),
        _notificationsRepository = notificationsRepository;

  @override
  DoNotDisturbState get initialState => DoNotDisturbInitial(false);

  @override
  Stream<DoNotDisturbState> mapEventToState(DoNotDisturbEvent event) async* {
    if (event is SilenceNotifications) {
      yield* _mapSilenceNotificationsToState(event);
    } else if (event is TurnOffSilentNotificatins) {
      yield* _mapTurnOffSilentNotificatinsToState(event);
    } else if (event is CheckSilenceNotificationStatus) {
      yield* _mapCheckSilenceNotificationStatusToState(event);
    }
  }

  Stream<DoNotDisturbState> _mapSilenceNotificationsToState(
      SilenceNotifications event) async* {
    await _notificationsRepository.enableSilence();
    yield SilencedNotifications();
  }

  Stream<DoNotDisturbState> _mapTurnOffSilentNotificatinsToState(
      TurnOffSilentNotificatins event) async* {
    await _notificationsRepository.disableSilence();
    yield TurnedOffSilentNotifications();
  }

  Stream<DoNotDisturbState> _mapCheckSilenceNotificationStatusToState(
      CheckSilenceNotificationStatus event) async* {
    bool isActive = await _notificationsRepository.isDndActive();
    yield DoNotDisturbInitial(isActive);
  }
}
