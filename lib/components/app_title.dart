import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class AppTitleWidget extends StatelessWidget {
  final Function onBackPressed;
  AppTitleWidget({this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Container(margin: EdgeInsets.only(left: 24, top: 24)),
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: PRIMARY_COLOR,
            ),
            alignment: Alignment.topLeft,
            onPressed: () {
              if (onBackPressed == null) {
                Navigator.pop(context);
              } else {
                onBackPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
