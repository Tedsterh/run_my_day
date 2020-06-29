import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_my_lockdown/blocs/weather/bloc/weather_bloc.dart';
import 'package:run_my_lockdown/pages/home_page/weather_widgets/weather_icons.dart';

class WeatherForcastTile extends StatelessWidget {
  const WeatherForcastTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Neumorphic(
            style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                shape: NeumorphicShape.flat,
                intensity: 0.0),
            child: Container(
              height: 120,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                if (state is LoadedWeather) {
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 100,
                        child: SvgPicture.asset(
                            'assets/weather_icons/${icons['${state.forecast.currently.icon}']}'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              titles[state.forecast.currently.icon],
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(height: 5),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  state.forecast.currently.temperature.toStringAsFixed(0) + ' °C',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  (state.forecast.currently.precipProbability * 100).toString() + '%  Chance of precipitation',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text(
                                  (state.forecast.currently.humidity * 100).toStringAsFixed(0) + '%  Humid',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
