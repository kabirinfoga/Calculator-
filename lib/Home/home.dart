import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 35.0;
  double resultFontSize = 40.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 35.0;
        resultFontSize = 40.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 35.0;
        resultFontSize = 40.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 35.0;
        resultFontSize = 40.0;
        expression = equation;
        expression = expression.replaceAll("X", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 40.0;
        resultFontSize = 35.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  final sysTemColor =
      SystemUiOverlayStyle(statusBarColor: Colors.blueGrey[900]);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(sysTemColor);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.accessibility_new_sharp)),
        ],
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Calculator",
          style: GoogleFonts.lato(fontSize: 22.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              result,
              style: GoogleFonts.lato(fontSize: 35.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              equation,
              style: GoogleFonts.lato(fontSize: 45.0, color: Colors.black),
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("AC", 1, Colors.blueGrey.shade900),
                      buildButton("⌫", 1, Colors.blueGrey.shade900),
                      buildButton("/", 1, Colors.amber.shade900),
                    ]),
                    TableRow(children: [
                      buildButton("9", 1, Colors.blueGrey.shade900),
                      buildButton("8", 1, Colors.blueGrey.shade900),
                      buildButton("7", 1, Colors.blueGrey.shade900),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.blueGrey.shade900),
                      buildButton("5", 1, Colors.blueGrey.shade900),
                      buildButton("6", 1, Colors.blueGrey.shade900),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.blueGrey.shade900),
                      buildButton("2", 1, Colors.blueGrey.shade900),
                      buildButton("3", 1, Colors.blueGrey.shade900),
                    ]),
                    TableRow(children: [
                      buildButton("0", 1, Colors.blueGrey.shade900),
                      buildButton("00", 1, Colors.blueGrey.shade900),
                      buildButton(".", 1, Colors.blueGrey.shade900),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [buildButton("X", 1, Colors.amber.shade900)]),
                    TableRow(
                        children: [buildButton("-", 1, Colors.amber.shade900)]),
                    TableRow(
                        children: [buildButton("+", 1, Colors.amber.shade900)]),
                    TableRow(
                        children: [buildButton("=", 2, Colors.amber.shade900)]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Expanded(
      child: InkWell(
        onTap: () => buttonPressed(buttonText),
        child: Container(
          margin: const EdgeInsets.all(1.0),
          height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
            color: buttonColor,
          ),
          child: Center(
            child: Text(
                buttonText,
                style: GoogleFonts.lato(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ),
    );
  }
}
