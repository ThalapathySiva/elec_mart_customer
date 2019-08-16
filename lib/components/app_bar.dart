import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            "assets/images/Vendor.png",
            height: 30,
            width: 30,
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              "Mobile Phones",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: PRIMARY_COLOR,
            )
          ],
        ),
        Icon(
          Icons.filter_list,
          color: PRIMARY_COLOR,
        )
      ],
    );
  }
}
