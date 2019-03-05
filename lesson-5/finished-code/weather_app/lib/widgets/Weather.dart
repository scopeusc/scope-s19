import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/models/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.white)),
        Text(weather.main, style: new TextStyle(color: Colors.white, fontSize: 32.0)),
        Text('${weather.temp.toStringAsFixed(0)}°C',  style: new TextStyle(color: Colors.white)),
        SvgPicture.network('https://www.metaweather.com/static/img/weather/${weather.icon}.svg'),
        Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.white)),
      ],
    );
  }
}