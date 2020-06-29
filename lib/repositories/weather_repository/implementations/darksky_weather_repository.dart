import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:run_my_lockdown/repositories/weather_repository/weather_repository.dart';

class DarkskyWeatherRepository extends WeatherRepositorty {
  var darksky = new DarkSkyWeather("***REMOVED***",
      language: Language.English, units: Units.UK2);

  @override
  Future<Forecast> getWeatherForcast({LatLng location}) async {
    return darksky.getForecast(location.latitude, location.longitude);
  }

  @override
  Future<Forecast> getSpecificTimeWeather(
      {DateTime dateTime, LatLng location}) {
    return darksky.getTimeMachineForecast(
        location.latitude, location.longitude, dateTime);
  }
}
