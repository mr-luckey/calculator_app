import 'package:calculator_app/provder.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class CalculatorSceeen extends StatefulWidget {
  const CalculatorSceeen({Key? key}) : super(key: key);

  @override
  State<CalculatorSceeen> createState() => _CalculatorSceeenState();
}

class _CalculatorSceeenState extends State<CalculatorSceeen> {
  String equation = '0';
  String result = '0';
  String expression = '';

  // Function for button working
  void buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == '⌫') {
        if (equation.length > 1) {
          equation = equation.substring(0, equation.length - 1);
        } else {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "error";
        }
      } else if (btnText == '%') {
        try {
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          double res = exp.evaluate(EvaluationType.REAL, cm);
          result = (res / 100).toString();
        } catch (e) {
          result = "error";
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget callButton(
      String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 80,
        child: TextButton(
          onPressed: () {
            buttonPressed(btnText);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(btnColor),
            foregroundColor: MaterialStateProperty.all<Color>(txtColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          child: Text(
            btnText,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.grey,
          // shape: BeveledRectangleBorder(
          //     borderRadius: BorderRadius.circular(10), side: BorderSide()),
          title: Center(
            child: Text(
              "Calculator",
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          leading: IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: Colors.red,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              })),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Display equation value
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            alignment: Alignment.centerRight,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                equation,
                style: TextStyle(color: Colors.red, fontSize: 38),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Display result
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            alignment: Alignment.centerRight,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                result,
                style: TextStyle(color: Colors.grey, fontSize: 60),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        callButton('AC', Colors.white, 80, Colors.red),
                        callButton('⌫', Colors.white, 80, Colors.grey),
                        callButton('%', Colors.white, 80, Colors.grey),
                        callButton('÷', Colors.white, 80, Colors.red),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        callButton('7', Colors.white, 80, Colors.grey),
                        callButton('8', Colors.white, 80, Colors.grey),
                        callButton('9', Colors.white, 80, Colors.grey),
                        callButton('×', Colors.white, 80, Colors.red),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        callButton('4', Colors.white, 80, Colors.grey),
                        callButton('5', Colors.white, 80, Colors.grey),
                        callButton('6', Colors.white, 80, Colors.grey),
                        callButton('-', Colors.white, 80, Colors.red),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        callButton('1', Colors.white, 80, Colors.grey),
                        callButton('2', Colors.white, 80, Colors.grey),
                        callButton('3', Colors.white, 80, Colors.grey),
                        callButton('+', Colors.white, 80, Colors.red),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child:
                              callButton('0', Colors.white, 170, Colors.grey),
                        ),
                        callButton('.', Colors.white, 80, Colors.grey),
                        callButton('=', Colors.white, 80, Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
