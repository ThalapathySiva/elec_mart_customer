import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
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
        text("Enter OTP", 30, PRIMARY_COLOR, false),
        ListView(
          padding: EdgeInsets.all(24),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                  "OTP Sent to +91 8899889988. Please enter the OTP to continue.",
                  style: TextStyle(fontSize: 14, color: BLACK_COLOR),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20),
            CustomTextField(
              labelText: "OTP",
              onChanged: (val) {},
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TeritoryButton(text: "Resend OTP", onpressed: () {}),
                PrimaryButtonWidget(
                    buttonText: "Verify",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigateScreens()));
                    })
              ],
            )
          ],
        )
      ],
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
