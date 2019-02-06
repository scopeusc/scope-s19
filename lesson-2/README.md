# Lesson #2
In this lesson we'll be building a startup name generator with Flutter that will introduce many of the core features of the framework and stand as a foundation for some of the other apps we build during the semester. 

## Part 1 (Hello World)
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

## Part 2 (Generating Names)
We're building a startup name generator, so we need something that can generate random english words for us. Luckily, there are packages for just about anything these days! In the file ```pubspec.yaml``` you'll see the list of current dependencies and so we need to add ```english_words: ^3.1.0``` to that file and then click "Packages get" to download our new package. 

*Note: For other useful packages that can be used with Flutter see https://pub.dartlang.org/* 

Jumping back to ```main.dart``` we need to import the english_words package with ```import 'package:english_words/english_words.dart';```

Instead of showing "Hello World" when the app loads, we want to change it to show a random startup name. The code below should do it

```dart
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random(); // Add this line.
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(    // Change "const" to "new".
          //child: const Text('Hello World'),   // Replace this text...
          child: new Text(wordPair.asPascalCase),  // With this text.
        ),
      ),
    );
  }
}
```

## Part 3 (Infinite Scrolling List)
All of the widgets we have been dealing with up to this point have been state*less*, meaning that their values are final and immutable. Flutter apps with state*ful* widgets are much more powerful, so let's change our implementation.

Implementing a stateful widget requires at least two classes: 1) a StatefulWidget class that creates an instance of 2) a State class. 

As a basic StatefulWidget Class we can use
```dart
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
```

 and our basic State Class should be
 
 ```dart
 class RandomWordsState extends State<RandomWords> {
  @override                                  
  Widget build(BuildContext context) {
    final WordPair wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase);
  }                                          
}
```

Now lets use our new classes to replace our current implementation by setting the ```child``` in the ```body``` to ```new RandomWords()```. If you reload the app now you should see that it still works!

Viewing just one name at a time isn't any fun though. We want to be able to see a list of names and scroll through them to find that perfect two word combo that will send a startup straight to unicorn land. The ```RandomWords``` widget is controlling what's on the screen so we'll need to add a few methods to that class to get it generating a list. 

First we'll add two variables to our class 
```dart
final List<WordPair> _suggestions = <WordPair>[];
final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
```

We also need a function that will generate names as we scroll, so let's create that.

```dart
Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // The itemBuilder callback is called once per suggested 
      // word pairing, and places each suggestion into a ListTile
      // row. For even rows, the function adds a ListTile row for
      // the word pairing. For odd rows, the function adds a 
      // Divider widget to visually separate the entries. Note that
      // the divider may be difficult to see on smaller devices.
      itemBuilder: (BuildContext _context, int i) {
        // Add a one-pixel-high divider widget before each row 
        // in the ListView.
        if (i.isOdd) {
          return new Divider();
        }

        // The syntax "i ~/ 2" divides i by 2 and returns an 
        // integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings 
        // in the ListView,minus the divider widgets.
        final int index = i ~/ 2;
        // If you've reached the end of the available word
        // pairings...
        if (index >= _suggestions.length) {
          // ...then generate 10 more and add them to the 
          // suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  ```

That function calls another function ```_buildRow``` which creates a row of our list for each name generated.

```dart
Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
```

Now that we have functions for building our list we need to update the ```build``` method for ```RandomWordsState``` to use our functions instead of directly calling the word generation library. 

```dart
@override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random(); // Delete these... 
    //return new Text(wordPair.asPascalCase); // ... two lines.

    return new Scaffold (                   // Add from here... 
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );                                      // ... to here.
  }
  ```
  
  Lastly, lets update the ```MyApp``` build function and change the home to our ```RandomWords``` widget.
  
  ```dart
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
  ```
  If you reload the app now you should get an infinite list of startup names! Now you can scroll to your heart's content. 
  
  Congratulations on creating your first **real** Flutter app :smiley: The concepts in this lesson will be useful in the weeks going forward and you can always look back at the code from previous weeks for reference in your projects. 
  
  ## Extra Material
  If you're interested on developing this app further Google has a tutorial that will walk you through adding other features and UI improvements that picks up where we left off [here](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2/index.html?index=..%2F..index#3). Show us the completed app next week for bonus points :thumbsup: :clap: :v:
