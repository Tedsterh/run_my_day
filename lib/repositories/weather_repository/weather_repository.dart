import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class WeatherRepositorty {
  Future<Forecast> getWeatherForcast({@required LatLng location});

  Future<Forecast> getSpecificTimeWeather(
      {@required DateTime dateTime, @required LatLng location});
}
