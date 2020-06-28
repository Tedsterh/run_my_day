import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class WeatherRepositorty {
  Future<dynamic> getWeatherForcast({@required LatLng location});

  Future<dynamic> getSpecificTimeWeather(
      {@required DateTime dateTime, @required LatLng location});
}
