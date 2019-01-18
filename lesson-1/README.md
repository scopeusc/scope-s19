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
Flutter is built using the programming language Dart which was just released last year. In order to jump into building Flutter apps, first we'll need to learn a bit about how Dart works. 

