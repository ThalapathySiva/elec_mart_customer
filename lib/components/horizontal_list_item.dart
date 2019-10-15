import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalListItem extends StatelessWidget {
  final String name, currentPrice, mrpPrice;
  final List imageURL;
  final bool showBorder;
  final bool outOfStock;
  final String id;

  HorizontalListItem(
      {this.id,
      this.imageURL,
      this.outOfStock = false,
      this.name,
      this.currentPrice,
      this.mrpPrice,
      this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (!name.toLowerCase().contains(appState.getSearchText.toLowerCase())) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: showBorder ? Border.all(width: 2, color: PRIMARY_COLOR) : null,
        color: GREY_COLOR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
              tag: id,
              child: Image.network("${imageURL[0]}", width: 80, height: 80)),
          Container(
            padding: EdgeInsets.only(bottom: 20, left: 10),
            width: MediaQuery.of(context).size.width / 1.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                priceWidget(mrpPrice, context),
                priceWidget(currentPrice, context, currentPrice: true),
                SizedBox(height: 10),
                if (outOfStock)
                  Text("OUT OF STOCK",
                      style: TextStyle(
                          fontSize: 11,
                          color: RED_COLOR,
                          fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceWidget(String price, context, {bool currentPrice = false}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        "₹ $price",
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: currentPrice ? 16 : 12,
            color: currentPrice ? PRIMARY_COLOR : RED_COLOR,
            fontWeight: FontWeight.bold,
            decoration: !currentPrice ? TextDecoration.lineThrough : null),
      ),
    );
  }
}
