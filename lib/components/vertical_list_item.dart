import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class VerticalListItem extends StatelessWidget {
  final String name, currentPrice, mrpPrice;
  final bool showBorder;
  final List imageURL;
  final String id;

  VerticalListItem(
      {this.id,
      this.name,
      this.currentPrice,
      this.mrpPrice,
      this.imageURL,
      this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        color: GREY_COLOR,
        border: showBorder ? Border.all(width: 2, color: PRIMARY_COLOR) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
              tag: id,
              child: Image.network("${imageURL[0]}", width: 110, height: 110)),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            height: 40,
            child: AutoSizeText(
              name.length < 16 ? "$name" : "${name.substring(0, 12) + ".."}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
      "₹ $price",
      style: TextStyle(
          fontSize: currentPrice ? 16 : 12,
          color: currentPrice ? PRIMARY_COLOR : RED_COLOR,
          fontWeight: FontWeight.bold,
          decoration: !currentPrice ? TextDecoration.lineThrough : null),
    );
  }
}
