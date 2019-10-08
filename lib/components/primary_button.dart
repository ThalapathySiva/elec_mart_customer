import 'package:flutter/material.dart';
import 'package:elec_mart_customer/constants/Colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color borderColor;
  final Color color;
  final IconData icon;

  PrimaryButtonWidget(
      {this.borderColor,
      this.color,
      this.buttonText,
      this.onPressed,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color == null ? PRIMARY_COLOR : color,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$buttonText',
            style: TextStyle(
                color: WHITE_COLOR,
                fontSize: 16,
                letterSpacing: 0,
                fontWeight: FontWeight.bold),
          ),
          if (icon != null) ...[
            Container(margin: EdgeInsets.only(left: 9)),
            Icon(
              icon,
              color: WHITE_COLOR,
            )
          ],
        ],
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: borderColor == null ? Colors.transparent : borderColor,
              width: 1.5),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
