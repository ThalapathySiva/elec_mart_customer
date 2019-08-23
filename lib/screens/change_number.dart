import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class ChangeNumber extends StatefulWidget {
  @override
  _ChangeNumber createState() => _ChangeNumber();
}

class _ChangeNumber extends State<ChangeNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(
      children: <Widget>[
        AppTitleWidget(),
        texts(),
        textFields(),
        continuee(),
      ],
    );
  }

  Widget texts() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          text("Change your Number", 30, PRIMARY_COLOR, false),
          text(
              "Enter your new phone number to use for login purposes. This will not be used for delivery.",
              14,
              BLACK_COLOR,
              false),
        ],
      ),
    );
  }

  Widget textFields() {
    return Container(
      padding: EdgeInsets.all(24),
      child: CustomTextField(
        labelText: "New Phone Number",
        onChanged: (val) {},
      ),
    );
  }

  Widget continuee() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(24),
            child:
                PrimaryButtonWidget(buttonText: "Continue", onPressed: () {}))
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
      textAlign: TextAlign.center,
    );
  }
}
