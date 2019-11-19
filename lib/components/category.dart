import 'package:elec_mart_customer/constants/Colors.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          selected
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: PRIMARY_COLOR),
                      borderRadius: BorderRadius.circular(30)),
                  child: ClipOval(
                    child: name == "All"
                        ? Icon(
                            Icons.all_inclusive,
                            color: BLACK_COLOR,
                            size: 50,
                          )
                        : Image.network(
                            categoryImage,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                )
              : ClipOval(
                  child: name == "All"
                      ? Icon(
                          Icons.all_inclusive,
                          color: BLACK_COLOR,
                          size: 50,
                        )
                      : Image.network(
                          categoryImage,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )),
          Text("$name",
              style: TextStyle(
                  color: selected ? PRIMARY_COLOR : GREY_COLOR.withOpacity(0.3),
                  fontSize: 12,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
