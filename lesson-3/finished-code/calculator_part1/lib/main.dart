import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: MainPage(
          opColor: Color.fromARGB(255, 103, 60, 206),
          opTextColor: Colors.white,
          utilColor: Colors.grey,
          utilTextColor: Colors.black,
          numColor: Color.fromARGB(255, 51, 51, 51),
          numTextColor: Colors.white,
      ),
    );
  }
}

class MainPage extends StatefulWidget {

  final Color opColor;
  final Color opTextColor;
  final Color utilColor;
  final Color utilTextColor;
  final Color numColor;
  final Color numTextColor;

  MainPage({Key key,
    @required this.opColor,
    @required this.opTextColor,
    @required this.utilColor,
    @required this.utilTextColor,
    @required this.numColor,
    @required this.numTextColor,
  }) : super(key: key);

  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          '0',
                          style: TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1 / 5 * 4,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.utilColor, textColor: this.widget.utilTextColor, text: "C", textSize: 30),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.utilColor, textColor: this.widget.utilTextColor, text: "+/-", textSize: 30),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.utilColor, textColor: this.widget.utilTextColor, text: "%", textSize: 30),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor,  text: "÷", textSize: 40),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "7", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "8", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "9", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "×", textSize: 40),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "4", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "5", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "6", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "-", textSize: 40),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "1", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "2", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "3", textSize: 35),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "+", textSize: 40),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "0", textSize: 30),
                          ),
                          Flexible(
                            flex: 1,
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: ".", textSize: 30),
                          ),
                          Flexible(
                            flex: 1,
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "=", textSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {

  final Color bgColor;
  final Color textColor;
  final double textSize;
  final String text;

  Button({Key key,
    this.bgColor,
    this.textColor,
    this.text,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: this.bgColor,
      ),
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: this.textSize,
            color: this.textColor,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
