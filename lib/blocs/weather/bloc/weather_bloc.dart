import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:run_my_lockdown/repositories/weather_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepositorty _weatherRepositorty;

  WeatherBloc({@required WeatherRepositorty weatherRepositorty})
      : assert(weatherRepositorty != null),
        _weatherRepositorty = weatherRepositorty;

  @override
  WeatherState get initialState => LoadingWeather();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherForcast) {
      yield* _mapGetWeatherForcastToState(event);
    }
  }

  Stream<WeatherState> _mapGetWeatherForcastToState(
      GetWeatherForcast event) async* {
    Location location = new Location();

    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        yield FailedToGetWeather();
      }
    }
    LocationData _locationData = await location.getLocation();
    Forecast forecast = await _weatherRepositorty.getSpecificTimeWeather(
        dateTime: event.currentDate,
        location: LatLng(_locationData.latitude, _locationData.longitude));
    yield LoadedWeather(forecast);
  }
}
