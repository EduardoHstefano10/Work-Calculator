import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

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

  Color getBackgroundColor() {
    return widget.isDarkMode ? Colors.black : Colors.white;
  }

  Color getTextColor() {
    return widget.isDarkMode ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    Widget calcButton(String btntxt, Color btncolor,
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
            } else if (btntxt == "+/-") {
              // Toggle sign
              handleSign();
            } else if (btntxt == "%") {
              // Calculate percentage
              calculatePercentage();
            } else {
              handleInput(btntxt);
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
            backgroundColor: MaterialStateProperty.all<Color>(
              operation ? Colors.orange : btncolor,
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(20),
            ),
          ),
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: fontSize,
              color: operation ? Colors.black : getTextColor(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: getBackgroundColor(),
      appBar: AppBar(
        title: Text(
          'Calculadora de Hernandez 😎',
          style: TextStyle(color: getTextColor()), // Añadir este estilo
        ),
        backgroundColor: getBackgroundColor(),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
              color: getTextColor(),
            ),
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
                  color: getTextColor(),
                  fontSize: 60,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Theme.of(context).primaryColor, fontSize: 24.0),
                calcButton('+/-', Theme.of(context).primaryColor, fontSize: 24.0),
                calcButton('%', Theme.of(context).primaryColor, fontSize: 24.0),
                calcButton('/', Theme.of(context).primaryColor, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Theme.of(context).primaryColor),
                calcButton('8', Theme.of(context).primaryColor),
                calcButton('9', Theme.of(context).primaryColor),
                calcButton('x', Theme.of(context).primaryColor, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Theme.of(context).primaryColor),
                calcButton('5', Theme.of(context).primaryColor),
                calcButton('6', Theme.of(context).primaryColor),
                calcButton('-', Theme.of(context).primaryColor, operation: true, fontSize: 24.0),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Theme.of(context).primaryColor),
                calcButton('2', Theme.of(context).primaryColor),
                calcButton('3', Theme.of(context).primaryColor),
                calcButton('+', Theme.of(context).primaryColor, operation: true, fontSize: 24.0),
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
                      backgroundColor: MaterialStateProperty.all<Color>(getBackgroundColor()),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(20),
                      ),
                    ),
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 28,
                        color: getTextColor(),
                      ),
                    ),
                  ),
                ),
                calcButton('.', Theme.of(context).primaryColor),
                calcButton('=', Theme.of(context).primaryColor, operation: true, fontSize: 24.0),
                calcButton('DEL', Theme.of(context).primaryColor, operation: false, fontSize: 24.0),
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
    if (result.isNotEmpty && result != '0' && result != 'ERROR') {
      result = result.substring(0, result.length - 1);
      finalResult = result;
      setState(() {
        text = finalResult;
      });
    } else if (result == '0' && currentOperation.isNotEmpty) {
      // Si result es '0' y hay una operación actual, elimina la operación y muestra el número anterior.
      currentOperation = currentOperation.substring(0, currentOperation.length - 1);
      setState(() {
        text = currentOperation;
      });
    } else if (result == '0' || result == 'ERROR') {
      // Si result es '0' o 'ERROR', no hacemos nada
    }
    if (result.isEmpty) {
      // Si la cadena está vacía, restablecemos a '0'
      result = '0';
      setState(() {
        text = result;
      });
    }
  }


  void handleSign() {
    if (result != '0' && result != 'ERROR') {
      if (result[0] == '-') {
        result = result.substring(1);
      } else {
        result = '-' + result;
      }
      finalResult = result;
      setState(() {
        text = finalResult;
      });
    }
  }

  void calculatePercentage() {
    if (result != '0' && result != 'ERROR') {
      numOne = double.parse(result);
      numOne = numOne / 100;
      result = numOne.toString();
      finalResult = result;
      setState(() {
        text = finalResult;
      });
    }
  }
}
