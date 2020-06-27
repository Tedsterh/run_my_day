part of 'icon_bloc.dart';

abstract class IconState extends Equatable {
  const IconState();

  @override
  List<Object> get props => [];
}

class IconInitial extends IconState {}

class ShowIconPicker extends IconState {
  final List<String> icons;

  ShowIconPicker(this.icons);

  @override
  List<Object> get props => [icons];

  @override
  String toString() => 'ShowIconPicker { icons: $icons }';
}

class ChosenIcon extends IconState {
  final String icon;

  ChosenIcon(this.icon);

  @override
  List<Object> get props => [icon];

  @override
  String toString() => 'ChosenIcon { icon: $icon }';
}