import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/vendor_detail_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ItemDetail extends StatefulWidget {
  final String description, name, vendorName, vendorAddress, callNumber;
  final InventoryItemModel inventory;

  ItemDetail(
      {this.description,
      this.name,
      this.vendorName,
      this.vendorAddress,
      this.callNumber,
      this.inventory});
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  GlobalKey<ScaffoldState> scaffold_state = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold_state,
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
              Hero(
                  tag: widget.inventory.id,
                  child: Image.network("${widget.inventory.imageURL}",
                      height: 500)),
              Container(margin: EdgeInsets.only(top: 10)),
              Text(
                widget.inventory.name,
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
            widget.inventory.description,
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
            name: widget.inventory.vendor.storeName,
            address: widget.inventory.vendor.address['addressLine'] +
                "\n" +
                widget.inventory.vendor.address['city'],
            adminPhoneNumber: widget.inventory.vendor.adminPhonenumber,
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    final cartState = Provider.of<CartState>(context);

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
                "Rs " + widget.inventory.originalPrice.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 18, decoration: TextDecoration.lineThrough),
              ),
              Text(
                "Rs " + widget.inventory.sellingPrice.toString(),
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
            onPressed: () {
              final snackBar =
                  SnackBar(content: Text('This item added to the cart !'));
              scaffold_state.currentState.showSnackBar(snackBar);
              cartState.setCartItems({
                "name": widget.inventory.name,
                "imageUrl": widget.inventory.imageURL,
                "itemId": widget.inventory.id,
                "price": widget.inventory.sellingPrice
              });
            },
          )
        ],
      ),
    );
  }
}
