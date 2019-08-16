import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final ValueChanged<String> onChanged;

  CustomTextField({this.labelText, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: LIGHT_BLUE_COLOR.withOpacity(0.03),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search for items",
            hintStyle: TextStyle(
                color: LIGHT_BLUE_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }
}
