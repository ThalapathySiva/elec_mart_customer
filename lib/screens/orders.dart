import 'package:elec_mart_customer/components/screen_indicator.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/order_detail.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: text("Orders", 16, BLACK_COLOR, true)),
            SizedBox(height: 20),
            text("ACTIVE ORDERS", 12, PRIMARY_COLOR, true),
            SizedBox(height: 10),
            activeOrders(),
            SizedBox(height: 20),
            text("PREVIOUS ORDERS", 12, PRIMARY_COLOR, true),
            SizedBox(height: 20),
            previousOrders(),
          ],
        ),
      ),
    );
  }

  Widget text(String title, double size, Color color, bool isBold) {
    return Text(
      "$title",
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : null),
    );
  }

  Widget activeOrders() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderDetail()));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: LIGHT_BLUE_COLOR, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: LIGHT_BLUE_COLOR.withOpacity(0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text("Order ID. 3454", 16, BLACK_COLOR, true),
                text("Rs. 3,45,560", 16, PRIMARY_COLOR, true)
              ],
            ),
            SizedBox(height: 5),
            text("Apple iPhone X, and 2 more items", 14, BLACK_COLOR, false),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ScreenIndicator(color: PRIMARY_COLOR),
                SizedBox(width: 5),
                ScreenIndicator(color: PRIMARY_COLOR),
                SizedBox(width: 5),
                ScreenIndicator(color: LIGHT_BLUE_COLOR),
                SizedBox(width: 5),
                ScreenIndicator(color: LIGHT_BLUE_COLOR)
              ],
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[text("Placed", 14, PRIMARY_COLOR, true)]),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text("Cash on Delivery", 14, PRIMARY_COLOR, true),
                text("Waiting for store confirmation", 12, BLACK_COLOR, true)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget previousOrders() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderDetail()));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: LIGHT_BLUE_COLOR.withOpacity(0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text("Order ID. 3452", 16, BLACK_COLOR, true),
                text("Rs. 3,45,560", 16, PRIMARY_COLOR, true)
              ],
            ),
            SizedBox(height: 5),
            text("Apple iPhone X, and 2 more items", 14, BLACK_COLOR, false),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ScreenIndicator(color: Colors.green),
                SizedBox(width: 5),
                ScreenIndicator(color: Colors.green),
                SizedBox(width: 5),
                ScreenIndicator(color: Colors.green),
                SizedBox(width: 5),
                ScreenIndicator(color: Colors.green)
              ],
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[text("Delivered", 14, Colors.green, true)]),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text("Cash on Delivery (Paid)", 14, PRIMARY_COLOR, true),
                text("Order Completed", 12, BLACK_COLOR, true)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
