import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _displayText = '0';

  void _handleInput(String input) {
    setState(() {
      if (input == '=') {
        _calculate();
      } else if (input == 'C') {
        _displayText = '0';
      } else {
        if (_displayText == '0') {
          _displayText = input;
        } else {
          _displayText += input;
        }
      }
    });
  }

  void _calculate() {
    List<String> parts = _displayText.split(RegExp(r"[+\-*/]"));
    double num1 = double.parse(parts[0]);
    double num2 = double.parse(parts[1]);
    String operator = _displayText.substring(parts[0].length, parts[0].length + 1);

    switch (operator) {
      case '+':
        _displayText = (num1 + num2).toString();
        break;
      case '-':
        _displayText = (num1 - num2).toString();
        break;
      case '*':
        _displayText = (num1 * num2).toString();
        break;
      case '/':
        _displayText = (num1 / num2).toString();
        break;
    }
  }

  String _getButtonLabel(int index) {
    if (index < 10) {
      return index.toString(); // Numbers 0-9
    } else if (index == 10) {
      return '+';
    } else if (index == 11) {
      return '-';
    } else if (index == 12) {
      return '*';
    } else if (index == 13) {
      return '/';
    } else if (index == 14) {
      return 'C'; // Clear button
    } else {
     return '=';
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2, // Increased flex for display
            child: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3, // Increased flex for keypad
            child: GridView.count(
              padding: EdgeInsets.all(5.0),
              crossAxisCount: 4,
              children: [
                ...List.generate(16, (index) => ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: () => _handleInput(_getButtonLabel(index)),
                    child: Container(
                      color: Colors.blue,
                      height: 64,
                      width: 64,
                      child: Center(
                        child: Text(
                         
                          _getButtonLabel(index),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
