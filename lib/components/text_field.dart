import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final double height, width;
  final ValueChanged<String> onChanged;
  final bool isSecure;
  final String errorText;
  final bool isNumeric;

  CustomTextField(
      {this.errorText,
      this.labelText,
      this.onChanged,
      this.height,
      this.width,
      this.isNumeric = false,
      this.isSecure = false});
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
        obscureText: isSecure,
        onChanged: onChanged,
        keyboardType: isNumeric ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
            border: InputBorder.none,
            errorText: errorText,
            hintText: "$labelText",
            hintStyle: TextStyle(
                color: LIGHT_BLUE_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ),
    );
  }
}
