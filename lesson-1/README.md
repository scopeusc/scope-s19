# Lesson #1
## Setup & Intro to Dart
Welcome to Scope Spring 2019! This semester we'll be learning the Flutter, which is Google's mobile app SDK for crafting high-quality native experiences on both iOS and Android. 

### Setup
The first thing we need to do is set up our development environment. There are a couple of different options for this but we'll be following along with Google's recommended setup which is using Android Studio. 


You can download Android Studio [here](https://developer.android.com/studio/) if you don't already have it installed.

Android Studio doesn't come with Flutter and Dart out of the box so we'll need to install the necessary plugins. 

To do this follow these steps:
Start Android Studio.
* Open plugin preferences (Preferences > Plugins on macOS, File > Settings > Plugins on Windows & Linux).
* Select Browse repositories, select the Flutter plugin and click Install.
* Click Yes when prompted to install the Dart plugin.
* Click Restart when prompted.

### Creating an App
Now its time to run our first Flutter app! There is a small default app that is created automatically when a project is created and so we'll use that to test if Flutter is installed and working properly. 

In order to do this an Android Studio, follow these steps:
1. Select File > New Flutter Project.
2. Select Flutter application as the project type, and press Next.
3. Make sure that the Flutter SDK Path text field specifies the location of the SDK. Install the SDK if you haven’t yet done so.
4. Enter a project name (for example, myapp), and press Next.
5. Click Finish.
6. Wait for Android Studio to install the SDK, and create the project.

Now it's time to run our app to make sure it works. In the Android Studio Toolbar you can select an Android device for running the app. If none are listed as available, select Tools> Android > AVD Manager and create one there. For details, see [Managing AVDs](https://developer.android.com/studio/run/managing-avds).
Click the run icon in the toolbar, or invoke the menu item Run > Run.

If you see a screen that looks like the one below, you're done with the setup!

![Flutter Starter App](https://flutter.io/assets/get-started/ios/starter-app-5e284e57b8dce587ea1dfdac7da616e6ec9dc263a409a9a8f99cf836340f47b8.png "Flutter Starter App")

The official steps for this setup are [here](https://flutter.io/docs/get-started/editor) which you can reference if needed.

### Testing Hot Relead
One of the last things we want to do is test one of Flutter's coolest development features, which is a super quick hot reload that lets developers change the code of a live running app without losing the app's state. This makes development and debugging much faster and so we should give it a try on the starter app we just created. 

1. Open lib/main.dart.
2. Change the string 'You have pushed the button this many times' to 'You have clicked the button this many times'
*Important: Do not stop your app. Let your app run.*
3. Save your changes: invoke Save All, or click Hot Reload offline_bolt.

You should see the string update on the app almost immediately after saving your changes. This feature comes in handy when making UI changes and so it's great to make use of it from the very beginning.

Now you're done with all of the setup and testing needed to work with Flutter!

## Intro to Dart
In order to jump into building Flutter apps, first we'll need to learn a bit about how Dart works, the programming language that Flutter is built in. 

Dart 1.0 was first revealed in 2011 but it wasn't until the release of Dart 2.0 in 2018 that it gained popularity due to its use in the Flutter SDK. 

Dart is an object-oriented, class defined, garbage-collected language using a C-style syntax that transcompiles optionally into JavaScript. It supports interfaces, mixins, abstract classes, generics, static typing, and a sound type system.

Dart can be used to build web, server, desktop, and mobile applications, but we'll be using it this semester to build exclusively mobile apps. 

Here's an example of some typical Dart code that you might see in an application

```dart
// Define a function.
printInteger(int aNumber) {
  print('The number is $aNumber.'); // Print to console.
}

// This is where the app starts executing.
main() {
  var number = 42; // Declare and initialize a variable.
  printInteger(number); // Call a function.
}
```

If you've programmed in C or C++ before this code should be pretty readable and intuitive to understand. Below are some important things to keep note of when programming in Dart

* Everything you can place in a variable is an object, and every object is an instance of a class. Even numbers, functions, and null are objects. All objects inherit from the Object class.

* Although Dart is strongly typed, type annotations are optional because Dart can infer types. In the code above, number is inferred to be of type int. When you want to explicitly say that no type is expected, use the special type dynamic.

* Dart supports generic types, like List<int> (a list of integers) or List<dynamic> (a list of objects of any type).

* Dart supports top-level functions (such as main()), as well as functions tied to a class or object (static and instance methods, respectively). You can also create functions within functions (nested or local functions).

* Unlike Java, Dart doesn’t have the keywords public, protected, and private. If an identifier starts with an underscore (_), it’s private to its library. For details, see Libraries and visibility.

* Dart tools can report two kinds of problems: warnings and errors. Warnings are just indications that your code might not work, but they don’t prevent your program from executing. Errors can be either compile-time or run-time. A compile-time error prevents the code from executing at all; a run-time error results in an exception being raised while the code executes.

As we go through different examples and projects thoughout the semester you'll become more familiar with how Dart works and why Flutter chose it as its language of choice for building awesome mobile apps. 