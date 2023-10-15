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
  dynamic text = '0';
  String currentOperation = ''; // Variable para rastrear la operación actual
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  @override
  Widget build(BuildContext context) {
    Widget calcButton(String btntxt, Color btncolor, Color textcolor, String btnText,
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
            if (btnText == 'DEL') {
              if (result.isNotEmpty) {
                setState(() {
                  result = result.substring(0, result.length - 1);
                  finalResult = result;
                });
              }
            } else {
              calculation(btnText);
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
          child: operation
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '+',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                ),
              ),
            ],
          )
              : Text(
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
            // Mostrar la operación actual en la parte superior
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                currentOperation,
                textAlign: TextAlign.right, // Alinea la operación a la derecha
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Theme.of(context).primaryColor, Colors.black, 'AC', fontSize: 24.0),
                calcButton('+/-', Theme.of(context).primaryColor, Colors.black, '+/-', fontSize: 24.0),
                calcButton('%', Theme.of(context).primaryColor, Colors.black, '%', fontSize: 24.0),
                calcButton('DEL', Theme.of(context).primaryColor, Colors.black, 'DEL', fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Theme.of(context).primaryColor, Colors.black, '7'),
                calcButton('8', Theme.of(context).primaryColor, Colors.black, '8'),
                calcButton('9', Theme.of(context).primaryColor, Colors.black, '9'),
                calcButton('/', Theme.of(context).primaryColor, Colors.black, '/', fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Theme.of(context).primaryColor, Colors.black, '4'),
                calcButton('5', Theme.of(context).primaryColor, Colors.black, '5'),
                calcButton('6', Theme.of(context).primaryColor, Colors.black, '6'),
                calcButton('x', Theme.of(context).primaryColor, Colors.black, 'x', fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Theme.of(context).primaryColor, Colors.black, '1'),
                calcButton('2', Theme.of(context).primaryColor, Colors.black, '2'),
                calcButton('3', Theme.of(context).primaryColor, Colors.black, '3'),
                calcButton('+', Theme.of(context).primaryColor, Colors.black, '+', operation: true, fontSize: 24.0),
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
                      calculation('0');
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
                calcButton('.', Theme.of(context).primaryColor, Colors.black, '.'),
                calcButton('=', Theme.of(context).primaryColor, Colors.black, '=', fontSize: 24.0),
                calcButton('+', Theme.of(context).primaryColor, Colors.black, '+', operation: true, fontSize: 24.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      currentOperation = ''; // Limpiar la operación actual
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add().toString();
      } else if (preOpr == '-') {
        finalResult = sub().toString();
      } else if (preOpr == 'x') {
        finalResult = mul().toString();
      } else if (preOpr == '/') {
        finalResult = div().toString();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (result.isNotEmpty) {
        if (numOne == 0) {
          numOne = double.parse(result);
        } else {
          if (result != '.') {
            numTwo = double.parse(result);
          }
        }
        if (opr == '+') {
          finalResult = add().toString();
        } else if (opr == '-') {
          finalResult = sub().toString();
        } else if (opr == 'x') {
          finalResult = mul().toString();
        } else if (opr == '/') {
          finalResult = div().toString();
        }
        preOpr = opr;
        opr = btnText;
        result = '';
        // Actualizar la operación actual
        currentOperation = '$numOne $preOpr $numTwo';
      }
    } else if (btnText == '%') {
      if (result.isNotEmpty) {
        result = (double.parse(result) / 100).toString();
        finalResult = doesContainDecimal(result).toString();
      }
    } else if (btnText == '.') {
      if (result.isNotEmpty && !result.contains('.')) {
        result = result + '.';
        finalResult = result;
      }
    } else if (btnText == '+/-') {
      if (result.isNotEmpty) {
        if (result.startsWith('-')) {
          result = result.substring(1);
        } else if (result != '0') {
          result = '-' + result;
        }
        finalResult = result;
      }
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  double add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  double doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return double.parse(splitDecimal[0]);
      }
    }
    return double.parse(result);
  }
}
