import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";
  String equation = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
        equation = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        num1 = double.parse(output);
        operand = buttonText;
        equation = output + " " + buttonText + " ";
        output = "0";
      } else if (buttonText == "=") {
        num2 = double.parse(output);
        if (operand == "+") {
          output = (num1 + num2).toString();
        }
        if (operand == "-") {
          output = (num1 - num2).toString();
        }
        if (operand == "*") {
          output = (num1 * num2).toString();
        }
        if (operand == "/") {
          if (num2 != 0) {
            output = (num1 / num2).toString();
          } else {
            output = "Error";
          }
        }
        equation = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output = output + buttonText;
        }
        equation = equation + buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, {Color color = Colors.white}) {
    return Expanded(
      child: AnimatedButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        enabled: true,
        height: 80.0,
        width: 80.0,
        shadowDegree: ShadowDegree.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("By: Eduardo Hernnadez-Celstino-Trejo"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/"),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*"),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton("0"),
                buildButton("C", color: Colors.red),
                buildButton("="),
                buildButton("+"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
