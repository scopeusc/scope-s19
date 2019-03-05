import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/models/WeatherData.dart';

class ForecastItem extends StatelessWidget {
  final WeatherData weather;

  ForecastItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather.name, style: new TextStyle(color: Colors.black)),
            Text(weather.main, style: new TextStyle(color: Colors.black, fontSize: 24.0)),
            Text('${weather.temp.toStringAsFixed(0)}°C',  style: new TextStyle(color: Colors.black)),
            SvgPicture.network('https://www.metaweather.com/static/img/weather/${weather.icon}.svg'),
            Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}