import 'package:flutter/material.dart';
import 'package:elec_mart_customer/constants/Colors.dart';

class SecondaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final IconData icon;
  final Color borderColor;
  final Color textColor;

  SecondaryButton(
      {this.textColor,
      this.borderColor,
      this.buttonText,
      this.onPressed,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
          onPressed: onPressed,
          borderSide: BorderSide(
              color: borderColor == null ? PRIMARY_COLOR : borderColor,
              width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: 16,
                    color: textColor == null ? PRIMARY_COLOR : textColor,
                    fontWeight: FontWeight.bold),
              ),
              if (icon != null) ...[
                Container(margin: EdgeInsets.only(left: 9)),
                Icon(
                  icon,
                  color: PRIMARY_COLOR,
                )
              ],
            ],
          )),
    );
  }
}
