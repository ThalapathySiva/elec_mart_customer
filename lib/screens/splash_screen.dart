import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: layout(), backgroundColor: PRIMARY_COLOR);
  }

  Widget layout() {
    return Container(child: Column(children: <Widget>[]));
  }
}
