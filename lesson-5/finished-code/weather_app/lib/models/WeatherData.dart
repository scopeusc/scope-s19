class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final String main;
  final String icon;

  WeatherData({this.date,this.name, this.temp, this.main, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final jsonRow = json['consolidated_weather'][0];
    return WeatherData(
      date: DateTime.parse(jsonRow['applicable_date'].toString()),
      name: json['title'],
      temp: jsonRow['the_temp'].toDouble() * 1.8 + 32,
      main: jsonRow['weather_state_name'],
      icon: jsonRow['weather_state_abbr']
    );
  }
}