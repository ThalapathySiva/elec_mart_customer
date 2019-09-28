import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final Color color;

  SettingsOption({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              customBorder: new CircleBorder(),
              splashColor: Colors.red,
              child: Icon(
                Icons.arrow_forward_ios,
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
