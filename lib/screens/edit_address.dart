import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
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
      ],
    );
  }

  Widget texts() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          text("Edit your Address", 30, PRIMARY_COLOR, false),
          text(
              "Please enter your details carefully. The phone number you provide here will be used for contacting you.",
              14,
              BLACK_COLOR,
              false)
        ],
      ),
    );
  }

  Widget textFields() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          CustomTextField(
            labelText: "Flat/Building",
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "Street/Locality",
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "Landmark",
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "City",
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "Phone Number",
            onChanged: (val) {},
          ),
          SizedBox(height: 50),
          Container(
            height: 50,
            width: 360,
            child: PrimaryButtonWidget(
              buttonText: "Save Changes",
              onPressed: () {},
            ),
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
      textAlign: TextAlign.center,
    );
  }
}
