import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Function onFilterPressed;
  final IconData iconRight;

  const CustomAppBar({this.onFilterPressed, this.iconRight});
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: WHITE_COLOR,
        width: MediaQuery.of(context).size.width,
        child: Row(
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
                  FeatherIcons.chevronDown,
                  color: PRIMARY_COLOR,
                )
              ],
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: widget.onFilterPressed,
              icon: Icon(widget.iconRight ?? FeatherIcons.sliders),
              color: PRIMARY_COLOR,
            )
          ],
        ),
      ),
    );
  }
}
