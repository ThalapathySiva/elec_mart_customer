import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(24),
        children: <Widget>[
          SizedBox(height: 50),
          Icon(FeatherIcons.checkCircle, size: 150, color: PRIMARY_COLOR),
          SizedBox(height: 10),
          orderPlaceText(),
          SizedBox(height: 20),
          cod(),
          SizedBox(height: 20),
          track(),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: PrimaryButtonWidget(
              buttonText: "Got it",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget orderPlaceText() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Text("Order Placed",
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
          SizedBox(height: 10),
          Text(
            "Your order has been sent to store. You will receive confirmation soon.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget track() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: SecondaryButton(
            buttonText: "Track Order Status", onPressed: () {}));
  }

  Widget cod() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(width: 2, color: GREY_COLOR),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 20, left: 10),
            width: MediaQuery.of(context).size.width / 1.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Icon(FeatherIcons.box, color: PRIMARY_COLOR),
                    SizedBox(width: 5),
                    Text("Cash on Delivery",
                        style: TextStyle(
                          fontSize: 16,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Text("Please pay on delivery of your order",
                      style: TextStyle(fontSize: 14)),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Rs. 3,45,560",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
