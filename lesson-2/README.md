# Lesson #2
In this lesson we'll be building a startup name generator with Flutter that will introduce many of the core features of the framework and stand as a foundation for some of the other apps we build during the semester. 

## Part 1
First we need to create a new Flutter app, which we'll name "startup_generator". This should give you the app that we got running last week. The first thing we're going to do is replace the code in ```main.dart``` with the code below so that we have a simple "Hello World" application.

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}
```

This example creates a simple Material app. Material is a visual design language that is standard on mobile and the web. Flutter offers a rich set of Material widgets that are prebuilt and ready for use by developers. If you'd like to learn more about Material Design you should check out the website [material.io](https://material.io/design/). Google also has Flutter specific development tutorials [here](https://material.io/collections/developer-tutorials/#flutter) which are really helpful. 

In the code above, there are some things worth noting 
* The main method uses fat arrow (=>) notation, which can be used for one-line functions or methods.

* The app extends StatelessWidget, which makes the app itself a widget. In Flutter, almost everything is a widget, including alignment, padding, and layout.

* The Scaffold widget, from the Material library, provides a default app bar, a title, and a body property that holds the widget tree for the home screen. The widget subtree can be quite complex.

* A widget's main job is to provide a build method that describes how to display the widget in terms of other, lower-level widgets.

* The body for this example consists of a Center widget containing a Text child widget. The Center widget aligns its widget subtree to the center of the screen.

You'll get more comfortable with the structure of apps in Flutter as we write more code, but if you ever find yourself stuck or wondering what a certain widget does, the [Flutter API Documentation](https://docs.flutter.io/) is a great place to go. 

## Part 2 
Coming soon...
