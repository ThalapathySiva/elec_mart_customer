import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class VerticalListItem extends StatelessWidget {
  final String name, currentPrice, mrpPrice;
  final bool showBorder;

  VerticalListItem(
      {this.name, this.currentPrice, this.mrpPrice, this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        color: GREY_COLOR,
        border: showBorder ? Border.all(width: 2, color: PRIMARY_COLOR) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/Rectangle.png",
          ),
          Container(
            width: 140,
            child: Text(
              "$name",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          priceWidget(mrpPrice),
          priceWidget(currentPrice, currentPrice: true),
        ],
      ),
    );
  }

  Widget priceWidget(String price, {bool currentPrice = false}) {
    return Text(
      "$price",
      style: TextStyle(
          fontSize: currentPrice ? 16 : 12,
          color: currentPrice ? PRIMARY_COLOR : RED_COLOR,
          fontWeight: FontWeight.bold,
          decoration: !currentPrice ? TextDecoration.lineThrough : null),
    );
  }
}
