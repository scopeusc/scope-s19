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

After your application is setup, we'll quickly add some dependencies to your `pubspec.yaml` file.  Go ahead and add the following lines to that file, within the `dependencies` section:

```yaml
  http: "^0.11.3+16"

  intl: "^0.15.6"

  flutter_svg: "^0.11.0+1"
```

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

```dart
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
```

## Part 3 – Building Our Weather Widgets

### Weather Widget
Next, we'll be building a widget to display information from our `WeatherData` class in a presentable fashion.  This will be the front-and-center visual component of our application.

Start off by creating a folder called `widgets` within the weather_app/lib folder of your project.  Our first widget will be named `Weather.dart`.

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

### ForecastItem Widget
In addition to the Weather widget, we'll also be building a widget to represent forecast weather data.  This will be displayed below the main Weather widget in our application.

Like the last widget, we'll be building this one within weather_app/lib/widgets.  We'll be naming this one `ForecastItem.dart`.

```dart
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
```

## Part 4 - Putting It All Together
So far, we've focused on building our model (the structures that we'll be using to store the responses from the MetaWeather API) and our widgets (the smaller components of our UI that we'll use to organize how we present information to the user).  Last but not least, we'll be building out the entry point of our application (`main.dart`).

Open up `weather_app/main.dart`.  You'll likely see skeleton code that Android Studio generates for you when creating a new project.  *Go ahead and remove all of this; we'll be building the Flutter application from the ground up.*

### Imports
We'll begin by adding the necessary imports for our application to run.  Paste the below import statements at the top of your `main.dart` file.

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/Weather.dart';
import 'package:weather_app/widgets/ForecastItem.dart';
import 'package:weather_app/models/WeatherData.dart';
import 'package:weather_app/models/ForecastData.dart';
import 'package:weather_app/models/LocationData.dart';
```

### MyApp Class
Next, we'll construct the main class for the application.  We'll be using a **Stateful Widget** for our application, in order to display dynamic data.  Our main class will call `createState()`, which we'll create next.

Include the following code after your import statements.  Notice that we've appended a line to point our main method at the constructor for MyApp.

```dart
void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}
```

### MyApp State
With our main class now setup, we'll get started on constructing the state.  Below is an outline of what our state will look like.

Please include the following skeleton code after your `MyApp` class:

```dart
class MyAppState extends State<MyApp> {
  bool isLoading = false;
  LocationData locationData;
  WeatherData weatherData;
  ForecastData forecastData;
  
  @override
  void initState() {
    
  }
  
  @override
  Widget build(BuildContext context) {
    
  }
  
  loadWeather() async {
    
  }
}
```

#### initState()
Within the body of `initState()`, we'll be setting up the initial application behavior.  This will consist of first making a call to the parent constructor, and then calling `loadWeather()`, which will query the MetaWeather API.

Replace the empty body of your `initState()` with the following:

```dart
    super.initState();
    loadWeather();
```

#### build()
Our build method will take care of setting up all of the UI elements.  This UI will consist of a MaterialApp with a title, theme, and home attribute.  Inside of our MaterialApp, we'll include Widgets within a centered, scaffolded, column.  Within the body of our `build()` method, we can get started with the code below as a foundation for our user interface.  This will appear similar to the code we've started with in the previous lessons.

```dart
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
                    // Adding our widgets here...
                  ]
              )
          )
      ),
    );
```

Within the children list above (of type widget), we'll be creating a widget for the main weather display.  Add the following widget to the list of children:

```dart
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
                    )
```

Additionally, we'll be displaying a card showing each weather data from each element of the ForecastData class.  Add a comma after your last widget, and include this widget after it:

```dart
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200.0,
                          child: forecastData != null ? ListView.builder(
                              itemCount: forecastData.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ForecastItem(weather: forecastData.list.elementAt(index))
                          ) : Container(),
                        ),
                      ),
                    )
```

#### loadWeather()
This method is where our calls to the MetaWeather API go.  We'll be using the endpoints detailed above to request the weather data at USC's latitude and longitude.  The following code snippet:
1. Makes a call to the MetaWeather API using USC's latitude and longitude to get our WOEID.
2. Verifies that a response was received and no error status codes were returned.
3. Makes two more calls to the MetaWeather API to acquire the current and forecast weather information.
4. Constructs the `weatherData` and `forecastData` instances.

Include the following code snippet withing `loadWeather()`:
```dart
    setState(() {
      isLoading = true;
    });

    final lat = 34.0224;
    final lon = -118.2851;
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
```

## Part 5 - Test It Out!
At this point, you should have all that you need to build your code and deploy it to a simulator (or your own device).  Save and run your application, and work on debugging any small issues that you may have!  

Congratulations on completing the final Flutter lesson for the semester!

## Bonus Challenges
 - Include high/low temperatures for each day that the weather is listed!
 - Allow the user to select either Fahrenheit or Celsius as the unit for degrees!
 - Detect your phone's location and replace USC's lat/long with your own!
