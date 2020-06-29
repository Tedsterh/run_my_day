part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class LoadingWeather extends WeatherState {}

class LoadedWeather extends WeatherState {
  final Forecast forecast;

  LoadedWeather(this.forecast);

  @override
  List<Object> get props => [forecast];
}

class FailedToGetWeather extends WeatherState {}
