import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorDetail extends StatelessWidget {
  final String name, address, adminPhoneNumber;

  VendorDetail({this.name, this.adminPhoneNumber, this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/Vendor.png",
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  vendorText(name, context, primary: true),
                  Container(margin: EdgeInsets.only(top: 5)),
                  vendorText(address, context),
                  Container(margin: EdgeInsets.only(top: 15)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SecondaryButton(
                          buttonText: "call",
                          onPressed: () {
                            launch("tel://$adminPhoneNumber");
                          },
                        )
                      ],
                    ),
                  )
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
