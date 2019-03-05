import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/Weather.dart';
import 'package:weather_app/widgets/WeatherItem.dart';
import 'package:weather_app/models/WeatherData.dart';
import 'package:weather_app/models/ForecastData.dart';
import 'package:weather_app/models/LocationData.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isLoading = false;
  LocationData locationData;
  WeatherData weatherData;
  ForecastData forecastData;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App: API Fetching',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text('Weather App: API Fetching'),
          ),
          body: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: weatherData != null ? Weather(weather: weatherData) : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLoading ? CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: new AlwaysStoppedAnimation(Colors.white),
                            ) : IconButton(
                              icon: new Icon(Icons.refresh),
                              tooltip: 'Refresh',
                              onPressed: loadWeather,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200.0,
                          child: forecastData != null ? ListView.builder(
                              itemCount: forecastData.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                          ) : Container(),
                        ),
                      ),
                    )
                  ]
              )
          )
      ),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    final lat = 34.0224;
    final lon = -118.2851;
//    print('https://www.metaweather.com/api/location/search/?lattlong=${lat.toString()},${lon.toString()}');
    final locationResponse = await http.get('https://www.metaweather.com/api/location/search/?lattlong=${lat.toString()},${lon.toString()}');
    if (locationResponse.statusCode == 200) {
      locationData = new LocationData.fromJson(jsonDecode(locationResponse.body));
      final weatherResponse = await http.get(
          'https://www.metaweather.com/api/location/${locationData.woeid.toString()}/');
      final forecastResponse = await http.get(
          'https://www.metaweather.com/api/location/${locationData.woeid.toString()}/');
      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}