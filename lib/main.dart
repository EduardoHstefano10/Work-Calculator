import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? CustomCalculatorTheme.darkTheme() : CustomCalculatorTheme.lightTheme(),
      home: Calculator(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}

class CustomCalculatorTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      hintColor: Colors.red,
      fontFamily: 'Roboto',
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.teal,
      hintColor: Colors.orange,
      fontFamily: 'Roboto',
    );
  }
}

class Calculator extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  Calculator({required this.toggleTheme, required this.isDarkMode});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  String currentOperation = '';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  @override
  Widget build(BuildContext context) {
    Widget calcButton(String btntxt, Color btncolor, Color textcolor,
        {bool operation = false, double fontSize = 28.0, double width = 75}) {
      return Container(
        width: width,
        height: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: btncolor,
        ),
        child: ElevatedButton(
          onPressed: () {
            if (btntxt == "=") {
              calculate();
            } else if (operation) {
              handleOperation(btntxt);
            } else if (btntxt == "AC") {
              clearAll();
            } else if (btntxt == "DEL") {
              deleteLastCharacter();
            } else {
              handleInput(btntxt);
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
            backgroundColor: MaterialStateProperty.all<Color>(
              operation ? Colors.orange : Colors.transparent,
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(20),
            ),
          ),
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: fontSize,
              color: textcolor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: widget.isDarkMode ? Icon(Icons.brightness_7) : Icon(Icons.brightness_4),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(10.0),
              child: Text(
                currentOperation,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Theme.of(context).primaryColor, Colors.black, fontSize: 24.0),
                calcButton('+/-', Theme.of(context).primaryColor, Colors.black, fontSize: 24.0),
                calcButton('%', Theme.of(context).primaryColor, Colors.black, fontSize: 24.0),
                calcButton('/', Theme.of(context).primaryColor, Colors.black, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Theme.of(context).primaryColor, Colors.black),
                calcButton('8', Theme.of(context).primaryColor, Colors.black),
                calcButton('9', Theme.of(context).primaryColor, Colors.black),
                calcButton('x', Theme.of(context).primaryColor, Colors.black, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Theme.of(context).primaryColor, Colors.black),
                calcButton('5', Theme.of(context).primaryColor, Colors.black),
                calcButton('6', Theme.of(context).primaryColor, Colors.black),
                calcButton('-', Theme.of(context).primaryColor, Colors.black, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Theme.of(context).primaryColor, Colors.black),
                calcButton('2', Theme.of(context).primaryColor, Colors.black),
                calcButton('3', Theme.of(context).primaryColor, Colors.black),
                calcButton('+', Theme.of(context).primaryColor, Colors.black, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  child: ElevatedButton(
                    onPressed: () {
                      handleInput('0');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(20),
                      ),
                    ),
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                calcButton('.', Theme.of(context).primaryColor, Colors.black),
                calcButton('=', Theme.of(context).primaryColor, Colors.black, fontSize: 24.0),
                calcButton('DEL', Theme.of(context).primaryColor, Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleInput(String input) {
    if (result == '0' || result == 'ERROR') {
      result = input;
    } else {
      result += input;
    }
    finalResult = result;
    setState(() {
      text = finalResult;
    });
  }

  void handleOperation(String operation) {
    if (opr != '') {
      calculate();
      preOpr = opr;
      opr = operation;
      currentOperation = '$numOne $preOpr';
    } else {
      opr = operation;
      numOne = double.parse(result);
      currentOperation = '$numOne $opr';
      result = '';
    }
  }

  void calculate() {
    if (opr != '' && result != '') {
      numTwo = double.parse(result);
      switch (opr) {
        case '+':
          result = (numOne + numTwo).toString();
          break;
        case '-':
          result = (numOne - numTwo).toString();
          break;
        case 'x':
        case '×':
          result = (numOne * numTwo).toString();
          break;
        case '/':
          if (numTwo != 0) {
            result = (numOne / numTwo).toString();
          } else {
            result = 'ERROR';
          }
          break;
      }
      opr = '';
      numOne = double.parse(result);
      currentOperation = '';
      finalResult = result;
      setState(() {
        text = finalResult;
      });
    }
  }

  void clearAll() {
    result = '0';
    currentOperation = '';
    numOne = 0;
    numTwo = 0;
    finalResult = '';
    opr = '';
    preOpr = '';
    setState(() {
      text = result;
    });
  }

  void deleteLastCharacter() {
    if (result.isNotEmpty) {
      result = result.substring(0, result.length - 1);
      finalResult = result;
      setState(() {
        text = finalResult;
      });
    }
  }
}
