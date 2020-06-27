part of 'icon_bloc.dart';

abstract class IconEvent extends Equatable {
  const IconEvent();

  @override
  List<Object> get props => [];
}

class SetInitial extends IconEvent {}

class PickIcon extends IconEvent {
  final BuildContext context;

  PickIcon(this.context);

  @override
  List<Object> get props => [context];
}

class IconSelected extends IconEvent {
  final String icon;

  IconSelected({@required this.icon});

  @override
  List<Object> get props => [icon];
}