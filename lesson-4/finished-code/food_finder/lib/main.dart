import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  Marker markerPrev;

  GoogleMapController mapController;

  int currRestaurant;
  List<Restaurant> restaurants = [
    Restaurant(
      name: "Panda Express",
      desc: "Panda Express at The Ronald Tutor Campus Center features USC’s acclaimed and award-winning modern Chinese cuisine. Reflective of USC's passion for Asian ingredients and cooking techniques, the cuisine is accompanied by polished service, opulent, contemporary décor and spectacular campus panoramas",
      url: "https://www.pandaexpress.com/",
      lat: 34.020519,
      lng: -118.286339,
      zoom: 15
    ),
    Restaurant(
      name: "Honeybird",
      desc: "Sunny, streamlined spot for buttermilk-brined fried chicken, plus salads, side dishes & mini pies.",
      url: "https://www.honeybirdla.com/",
      lat: 34.024744,
      lng: -118.284417,
      zoom: 15
    ),
    Restaurant(
        name: "Cava",
        desc: "CAVA is a growing Mediterranean culinary brand with a flavorful and healthy fast-casual restaurant experience featuring customizable & craveable salads, grain bowls, pitas, and house-made juices. CAVA’s chef-crafted dips and spreads are available at Whole Foods Market and other specialty markets across the country.",
        url: "https://cava.com/",
        lat: 34.024902,
        lng: -118.284582,
        zoom: 15
    ),
    Restaurant(
        name: "Chick-fil-A",
        desc: "Fast-food chain serving chicken sandwiches, strips & nuggets along with salads & sides.",
        url: "http://www.chick-fil-a.com/usc",
        lat: 34.016617,
        lng: -118.282555,
        zoom: 15
    ),
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showRandomRestaurant() async {
    this.setState(() {
      final _random = new Random();
      int next = 0;
      while((next = _random.nextInt(this.restaurants.length)) == this.currRestaurant);
      this.currRestaurant = next;
    });

    var r = this.restaurants[this.currRestaurant];
    this.mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(r.lat, r.lng),
        r.zoom,
      ),
    );
    var marker = await this.mapController.addMarker(MarkerOptions(
      position: LatLng(r.lat, r.lng),
      visible: true,
      //infoWindowText: InfoWindowText(r.name, r.desc),
    ));
    if (this.markerPrev != null) {
      this.mapController.removeMarker(this.markerPrev);
    }
    this.markerPrev = marker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(34.021574, -118.286659),
              zoom: 15,
            ),
          ),
          _buildInfoCard(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showRandomRestaurant,
        child: Icon(Icons.restaurant),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return this.currRestaurant == null ? Container() : SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.restaurants[this.currRestaurant].name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  this.restaurants[this.currRestaurant].desc,
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('WEBSITE'),
                        onPressed: () { _launchURL(this.restaurants[this.currRestaurant].url); },
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class Restaurant {
  final String name, desc, url;
  final double lat, lng, zoom;

  Restaurant({this.name, this.desc, this.url, this.lat, this.lng, this.zoom});
}