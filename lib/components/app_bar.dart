import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final Function onFilterPressed;
  final Function onCategoryPressed;
  final String selectedName;
  final IconData iconRight;
  final bool isFilter;
  final bool isExpanded;
  

  const CustomAppBar(
      {this.isExpanded,
      this.isFilter,
      this.selectedName,
      this.onCategoryPressed,
      this.onFilterPressed,
      this.iconRight});
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
            GestureDetector(
              onTap: widget.onCategoryPressed,
              child: Row(
                children: <Widget>[
                  Text(
                    "${widget.selectedName}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    !widget.isFilter && widget.isExpanded
                        ? FeatherIcons.chevronUp
                        : FeatherIcons.chevronDown,
                    color: PRIMARY_COLOR,
                  )
                ],
              ),
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
