part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherForcast extends WeatherEvent {
  final DateTime currentDate;

  GetWeatherForcast(this.currentDate);

  @override
  List<Object> get props => [currentDate];
}
