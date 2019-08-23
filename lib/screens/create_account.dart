import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/otp.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
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
            padding: EdgeInsets.all(24),
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10),
              text("Create new account", 30, PRIMARY_COLOR, false),
              SizedBox(height: 50),
              loginInfo(),
              SizedBox(height: 50),
              choosePassword(),
            ],
          ),
        ),
        bottom()
      ],
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
          TeritoryButton(
            text: "Back",
            onpressed: () {},
          ),
          PrimaryButtonWidget(
            buttonText: "Next",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OTPScreen()));
            },
          )
        ],
      ),
    );
  }

  Widget loginInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text("Login information", 16, BLACK_COLOR, true),
        SizedBox(height: 30),
        CustomTextField(
          labelText: "Name",
          onChanged: (val) {},
        ),
        SizedBox(height: 20),
        CustomTextField(
          labelText: "Phone Number",
          onChanged: (val) {},
        ),
        SizedBox(height: 20),
        CustomTextField(
          labelText: "Email Address",
          onChanged: (val) {},
        )
      ],
    );
  }

  Widget choosePassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text("Choose a password", 16, BLACK_COLOR, true),
        SizedBox(height: 30),
        CustomTextField(
          labelText: "Password",
          onChanged: (val) {},
        ),
        SizedBox(height: 20),
        CustomTextField(
          labelText: "Confirm Password",
          onChanged: (val) {},
        ),
        SizedBox(height: 20),
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
