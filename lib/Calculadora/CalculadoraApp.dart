import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        _output = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (text == "+" || text == "-" || text == "x" || text == "/") {
        _operand = text;
        _num1 = double.parse(_output);
        _output = "";
      } else if (text == "=") {
        _num2 = double.parse(_output);
        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operand == "x") {
          _output = (_num1 * _num2).toString();
        } else if (_operand == "/") {
          if (_num2 != 0) {
            _output = (_num1 / _num2).toString();
          } else {
            _output = "Error";
          }
        }
        _operand = "";
        _num1 = 0;
        _num2 = 0;
      } else {
        _output += text;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("x"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("0"),
                    _buildButton("C"),
                    _buildButton("="),
                    _buildButton("+"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
