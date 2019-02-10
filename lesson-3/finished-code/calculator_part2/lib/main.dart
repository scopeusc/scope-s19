import 'package:flutter/material.dart';
import 'dart:math';

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
  double prev = 0;
  double curr = 0;
  String operator = '+';
  int decimalOffset = 0;

  onNumTap(int num) {
    setState(() {
      if(decimalOffset == 0) {
        this.curr = this.curr * 10 + num;
      } else {
        this.curr = this.curr + num * pow(10, -decimalOffset);
        ++this.decimalOffset;
      }
    });
  }

  onDecimalTap() {
    setState(() {
      if(this.decimalOffset == 0) {
        this.decimalOffset = 1;
      }
    });
  }

  onOperatorTap(String operator) {
    setState(() {
      this.operator = operator;
      this.prev = this.curr;
      this.curr = 0;
      this.decimalOffset = 0;
    });
  }

  onClearTap() {
    setState(() {
      this.prev = 0;
      this.curr = 0;
      this.operator = '+';
      this.decimalOffset = 0;
    });
  }

  onEqualTap() {
    setState((){
      switch(this.operator) {
        case '+':
          this.curr = this.prev + this.curr;
          break;
        case '-':
          this.curr = this.prev - this.curr;
          break;
        case '*':
          this.curr = this.prev * this.curr;
          break;
        case '/':
        default:
          this.curr = this.prev / this.curr;
          break;
      }
    });
  }

  onNegateTap() {
    setState(() {
      this.curr *= -1;
    });
  }

  onPercentTap() {
    setState(() {
      this.curr /= 100;
    });
  }

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
                          this.curr.toString(),
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
                            child: Button(bgColor: this.widget.utilColor, textColor: this.widget.utilTextColor, text: "C", textSize: 30, onTap: onClearTap),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.utilColor, textColor: this.widget.utilTextColor, text: "+/-", textSize: 30, onTap: onNegateTap),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.utilColor, textColor: this.widget.utilTextColor, text: "%", textSize: 30, onTap: onPercentTap),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor,  text: "÷", textSize: 40, onTap: () => onOperatorTap('/')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "7", textSize: 35, onTap: () => onNumTap(7)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "8", textSize: 35, onTap: () => onNumTap(8)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "9", textSize: 35, onTap: () => onNumTap(9)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "×", textSize: 40, onTap: () => onOperatorTap('*')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "4", textSize: 35, onTap: () => onNumTap(4)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "5", textSize: 35, onTap: () => onNumTap(5)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "6", textSize: 35, onTap: () => onNumTap(6)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "-", textSize: 40, onTap: () => onOperatorTap('-')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "1", textSize: 35, onTap: () => onNumTap(1)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "2", textSize: 35, onTap: () => onNumTap(2)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "3", textSize: 35, onTap: () => onNumTap(3)),
                          ),
                          Expanded(
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "+", textSize: 40, onTap: () => onOperatorTap('+')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: "0", textSize: 30, onTap: () => onNumTap(0)),
                          ),
                          Flexible(
                            flex: 1,
                            child: Button(bgColor: this.widget.numColor, textColor: this.widget.numTextColor, text: ".", textSize: 30, onTap: onDecimalTap),
                          ),
                          Flexible(
                            flex: 1,
                            child: Button(bgColor: this.widget.opColor, textColor: this.widget.opTextColor, text: "=", textSize: 40, onTap: onEqualTap),
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
  final void Function() onTap;

  Button({Key key,
    this.bgColor,
    this.textColor,
    this.text,
    this.textSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
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
      ),
    );
  }
}
