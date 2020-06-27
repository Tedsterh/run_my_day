part of 'do_not_disturb_bloc.dart';

abstract class DoNotDisturbState extends Equatable {
  const DoNotDisturbState();

  @override
  List<Object> get props => [];
}

class DoNotDisturbInitial extends DoNotDisturbState {}

class SilencedNotifications extends DoNotDisturbState {}

class TurnedOffSilentNotifications extends DoNotDisturbState {}