import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String name, categoryImage;
  final bool selected;

  Category({this.selected = false, this.name, this.categoryImage});
  @override
  Widget build(BuildContext context) {
    return layout();
  }

  Widget layout() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 56,
        width: 75,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                categoryImage,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("$name",
                    style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                selected
                    ? Icon(FeatherIcons.checkCircle, color: PRIMARY_COLOR)
                    : Container()
              ],
            ),
          ],
        ));
  }
}
