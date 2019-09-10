import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTitleWidget(),
              Container(padding: EdgeInsets.only(top: 24)),
              Center(
                child: Image.asset(
                  'assets/images/Rectangle.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Container(padding: EdgeInsets.only(top: 24)),
              Center(
                child: Text(
                  'App Name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'v 1.0',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ],
                  )),
              Container(padding: EdgeInsets.only(top: 24)),
              Center(
                child: Text(
                  'App Tagline',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24),
                child: Text(
                  'DEVELOPED BY',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: PRIMARY_COLOR),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'TEAM ',
                    style: TextStyle(fontSize: 28, fontFamily: 'IBMPlexMono'),
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                  Text(
                    '404FOUND',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
              ),
              Center(
                child: SecondaryButton(
                  buttonText: 'About us',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/flutter_logo.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Made with Flutter',
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
