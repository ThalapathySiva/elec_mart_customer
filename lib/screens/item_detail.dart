import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/vendor_detail_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatefulWidget {
  final String description, name, vendorName, vendorAddress, callNumber;

  ItemDetail(
      {this.description,
      this.name,
      this.vendorName,
      this.vendorAddress,
      this.callNumber});
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return Column(
      children: <Widget>[
        AppTitleWidget(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            children: <Widget>[
              Image.asset("assets/images/mobile.png"),
              Container(margin: EdgeInsets.only(top: 10)),
              Text(
                "Apple iPhone X - 64 GB / Rose Gold",
                style: TextStyle(color: PRIMARY_COLOR, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Container(margin: EdgeInsets.only(top: 10)),
              descp(),
              Container(margin: EdgeInsets.only(top: 10)),
              vendorDetails(),
            ],
          ),
        ),
        bottom(),
      ],
    );
  }

  Widget descp() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Item Description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ut libero libero. Sed feugiat, nibh vitae fermentum dictum, metus nisl convallis eros, non finibus mauris ipsum quis massa.",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget vendorDetails() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sold By",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          VendorDetail(
            name: "Vineesh",
            address:
                "NO 36 K C K NAGAR ARNI PALAYAM ARANI 632301 TV MALAI TAMILNADU INDIA ASIA EARTH SOLAR SYSTEM",
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Rs. 56 000",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 18, decoration: TextDecoration.lineThrough),
              ),
              Text(
                "Rs. 36 000",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 26,
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          PrimaryButtonWidget(
            buttonText: "Add to cart",
            icon: FeatherIcons.shoppingCart,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
