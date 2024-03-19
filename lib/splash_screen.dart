import 'dart:async';

import 'package:calculator_app/calculator%20screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CalculatorSceeen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cal.jpg', height: 100.0),
            SizedBox(height: 24),
            Text(
              'Calculator App',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitFadingCircle(
              color: Colors.black,
              size: 50.0,
              //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            ),
          ],
        ),
      ),
    );
  }
}
