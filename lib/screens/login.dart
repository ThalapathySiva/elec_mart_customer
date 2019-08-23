import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/create_account.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(
      children: <Widget>[
        // Image.asset("assets/images/image.png",
        //     fit: BoxFit.fitWidth,
        //     height: 300,
        //     width: MediaQuery.of(context).size.width),
        login(),
        SizedBox(height: MediaQuery.of(context).size.height / 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 110),
          child: SecondaryButton(
            buttonText: "Create Account",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateAccount()));
            },
          ),
        )
      ],
    );
  }

  Widget login() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("Login", 36, PRIMARY_COLOR, true),
          SizedBox(height: 30),
          CustomTextField(
            labelText: "Phone Number",
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "Password",
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              PrimaryButtonWidget(
                buttonText: "Login",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigateScreens()));
                },
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
