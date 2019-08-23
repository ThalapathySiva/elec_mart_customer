import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/cart_item.dart';
import 'package:elec_mart_customer/components/screen_indicator.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/vendor_detail_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
          AppTitleWidget(),
          firstRow(),
          secondRow(),
          firstColumn(),
          itemsInOrder(),
          address(),
          vendor(),
          finalColumn(),
        ],
      ),
    );
  }

  Widget firstRow() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text("Order ID. 3454", 16, BLACK_COLOR, true),
              text("Rs. 3,45,560", 24, PRIMARY_COLOR, true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              text("Cash on Delivery", 14, PRIMARY_COLOR, true)
            ],
          )
        ],
      ),
    );
  }

  Widget secondRow() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          text("ORDER STATUS", 12, PRIMARY_COLOR, true),
          Row(
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
        ],
      ),
    );
  }

  Widget firstColumn() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("Waiting for store confirmation", 20, PRIMARY_COLOR, true),
          SizedBox(height: 5),
          text(
              "We’re waiting for the store to confirm your order. Once confirmed, your order will be packaged and shipped.",
              14,
              BLACK_COLOR,
              false),
        ],
      ),
    );
  }

  Widget itemsInOrder() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("ITEMS IN ORDER", 12, PRIMARY_COLOR, true),
          SizedBox(height: 5),
          listItems()
        ],
      ),
    );
  }

  Widget listItems() {
    return ListView.separated(
      physics: ScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return CartItem(
          name: "Apple iPhone X - 64 GB, Rose Gold",
          currentPrice: "Rs. 194,500",
        );
      },
    );
  }

  Widget vendor() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("SOLD BY", 12, PRIMARY_COLOR, true),
          VendorDetail(
            name: "Vendor Name",
            address: "Vendor Address",
          )
        ],
      ),
    );
  }

  Widget address() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("SHIPPING ADDRESS", 12, PRIMARY_COLOR, true),
          SizedBox(height: 10),
          text("Mr. Vineesh 10/45,", 14, BLACK_COLOR, true),
          text("10/45, ABC Street, Lorem Ipsum,", 14, BLACK_COLOR, true),
          text("Coimbatore - 456067", 14, BLACK_COLOR, true),
          text("+91 8898896969", 14, PRIMARY_COLOR, true),
        ],
      ),
    );
  }

  Widget finalColumn() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
              onTap: () {},
              child: text("ORDER ACTIONS", 12, PRIMARY_COLOR, true)),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SecondaryButton(
                buttonText: "Call Vendor",
                onPressed: () {},
              ),
              TeritoryButton(
                text: "Cancel Order",
                onpressed: () {},
              )
            ],
          )
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
}
