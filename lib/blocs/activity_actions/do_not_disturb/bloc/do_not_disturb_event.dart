part of 'do_not_disturb_bloc.dart';

abstract class DoNotDisturbEvent extends Equatable {
  const DoNotDisturbEvent();

  @override
  List<Object> get props => [];
}

class SilenceNotifications extends DoNotDisturbEvent {}

class TurnOffSilentNotificatins extends DoNotDisturbEvent {}