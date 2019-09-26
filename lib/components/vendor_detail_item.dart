import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class VendorDetail extends StatelessWidget {
  final String name, address, storeImage;

  VendorDetail({this.name, this.address, this.storeImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Image.network(storeImage, height: 80, width: 80),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  vendorText(name, context, primary: true),
                  Container(margin: EdgeInsets.only(top: 5)),
                  vendorText(address, context),
                  Container(margin: EdgeInsets.only(top: 15)),
                ]),
          ),
        ],
      ),
    );
  }

  Widget vendorText(String text, context, {bool primary = false}) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: Text(
        "$text",
        style: TextStyle(
          fontSize: primary ? 18 : 12,
          fontWeight: FontWeight.bold,
          color: !primary ? LIGHT_BLACK_COLOR : null,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
