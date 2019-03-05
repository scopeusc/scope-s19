import 'package:weather_app/models/WeatherData.dart';

class ForecastData {
  final List list;

  ForecastData({this.list});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List list = new List();

    for (dynamic e in json['consolidated_weather']) {
      WeatherData w = new WeatherData(
          date: DateTime.parse(e['applicable_date'].toString()),
          name: json['title'],
          temp: e['the_temp'].toDouble() * 1.8 + 32,
          main: e['weather_state_name'],
          icon: e['weather_state_abbr']);
      list.add(w);
    }

    return ForecastData(
      list: list,
    );
  }
}