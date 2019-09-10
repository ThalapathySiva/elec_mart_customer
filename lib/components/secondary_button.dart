import 'package:flutter/material.dart';
import 'package:elec_mart_customer/constants/Colors.dart';

class SecondaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final IconData icon;

  SecondaryButton({this.buttonText, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
          onPressed: onPressed,
          borderSide: BorderSide(color: PRIMARY_COLOR, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: 16,
                    color: PRIMARY_COLOR,
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
