import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final double height, width;
  final ValueChanged<String> onChanged;

  CustomTextField({this.labelText, this.onChanged, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: LIGHT_BLUE_COLOR.withOpacity(0.03),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "$labelText",
            hintStyle: TextStyle(
                color: LIGHT_BLUE_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }
}
