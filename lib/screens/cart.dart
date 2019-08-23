import 'package:elec_mart_customer/components/cart_item.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/edit_address.dart';
import 'package:elec_mart_customer/screens/order_placed.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return Container(
      child: ListView(
        children: <Widget>[
          listItems(),
          totalRow(),
          Container(height: 3, color: GREY_COLOR),
          address(),
          Container(height: 3, color: GREY_COLOR),
          Container(
            padding: EdgeInsets.all(24),
            child: PrimaryButtonWidget(
              buttonText: "Proceed to Payment",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderPlaced()));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listItems() {
    return ListView.separated(
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(24),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return CartItem(
          name: "Apple iPhone X - 64 GB, Rose Gold",
          currentPrice: "Rs. 194,500",
          canDelete: true,
        );
      },
    );
  }

  Widget totalRow() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          text("Total", 16, BLACK_COLOR, true),
          text("Rs. 3,45,560", 20, PRIMARY_COLOR, true)
        ],
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

  Widget address() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FeatherIcons.truck),
                  SizedBox(width: 10),
                  text("Shipping Address", 16, BLACK_COLOR, true),
                ],
              ),
              SecondaryButton(
                buttonText: "Edit",
                icon: FeatherIcons.edit2,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditAddress()));
                },
              )
            ],
          ),
          text("Mr. Vineesh 10/45,", 14, BLACK_COLOR, true),
          text("10/45, ABC Street, Lorem Ipsum,", 14, BLACK_COLOR, true),
          text("Coimbatore - 456067", 14, BLACK_COLOR, true),
          text("+91 8898896969", 14, BLACK_COLOR, true),
        ],
      ),
    );
  }
}
