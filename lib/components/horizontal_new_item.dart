import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class HorizontalNewItem extends StatelessWidget {
  final String name, currentPrice, mrpPrice;

  HorizontalNewItem({
    this.name,
    this.currentPrice,
    this.mrpPrice,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          child: HorizontalListItem(
            name: name,
            currentPrice: currentPrice,
            mrpPrice: mrpPrice,
            showBorder: true,
          ),
        ),
        newLabel()
      ],
    );
  }

  Positioned newLabel() {
    return Positioned(
      right: 20,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: PRIMARY_COLOR,
        ),
        child: Text(
          "NEW",
          style: TextStyle(
              color: WHITE_COLOR,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
