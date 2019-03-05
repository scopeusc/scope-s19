# Lesson 5 – Weather App: API Fetching
For our last lesson, we will be building a Flutter application to fetch and parse weather data from MetaWeather.

## Part 1 - Visit the MetaWeather Docs
The API documentation for MetaWeather is located [here](https://www.metaweather.com/api/).  By making two calls to this API, we can acquire current weather data for the a given location.  The process for this is as follows:

### Perform a Location Search
In order to request the current weather information for a particular location, we first must obtain the corresponding WOEID ("Where On Earth ID").

The respective URL endpoint for this query is: `https://www.metaweather.com/api/location/search/?lattlong=(latt),(long)`. You'll need to reference this later on.

*Example Usage:* https://www.metaweather.com/api/location/search/?lattlong=34.0224,-118.2851

MetaWeather's response fields (for a string query) include:

| Field        | Type  |
|:------------:|:-----:|
| title        | string|
| location_type| string|
| latt_long    | floats|
| woeid        | int   |

From our query results, we'll be saving the WOEID for later use.

### Perform a Weather Query Using WOEID
As some further background on the MetaWeather API, after obtaining the WOEID then we must perform a query on the current weather at that location.

The respective URL endpoint for this query is `https://www.metaweather.com/api/location/(woeid)/`. You'll need to reference this later on, too.

*Example Usage:* https://www.metaweather.com/api/location/2487956/

## Part 2 - Setting Up the Data Models
We'll be three classes to represent the data that we retrieve from the MetaWeather API.  We'll begin by initializing our project and setting up these classes.

### Project Setup
Begin by launching Android Studio and creating a new Flutter Application.  In order to use the same imports listed in our code snippets, be sure to name your Flutter Application `weather_app`.

### LocationData Class
As we mentioned in the API introduction, our first call to the MetaWeather endpoints will be passing in a latitude and a longitude to obtain the desired location's WOEID ("Where On Earth ID").  Along with the the WOEID, we'll also want to save the title of the location, in order to display it within our Flutter application.

Create a folder within weather_app/lib called `models` and create a new Dart file called `LocationData.dart` with the following contents:
```dart
class LocationData {
  final String title;
  final int woeid;

  LocationData({this.title,this.woeid});

  factory LocationData.fromJson(List<dynamic> json) {
    return LocationData(
      title: json[0]['title'],
      woeid: json[0]['woeid']
    );
  }
}
```

As you can see, our constructor takes the two parameters we mentioned (title and WOEID).  The values of these parameters are obtained by parsing the json response that we'll receive from the MetaWeather API.

### WeatherData Class
Next, we'll be working on a class to save the basic, weather-related information for a given date.  We'll call this class `WeatherData.dart`, storing it in weather_app/lib/models, too.

```dart
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
```

### ForecastData Class

## Part 3 – Building Our Weather Widgets

### Weather Widget
Next, we'll be building a widget to display information from our `WeatherData` class in a presentable fashion.  This will be the front-and-center visual component of our application.

Start off by creating a folder for widgets within the weather_app/lib folder of your project.  Our first widget will be called `Weather.dart`.
```dart
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
```
### WeatherItem Widget

## Part 4 - Putting It All Together

## Bonus Challenges
TODO
