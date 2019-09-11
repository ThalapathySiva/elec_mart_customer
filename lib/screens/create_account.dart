import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/dialog_style.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/UserModel.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:elec_mart_customer/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'graphql/customerRegister.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  Map input = {
    "name": "",
    "phoneNumber": "",
    "email": "",
    "password": "",
    "confirmPassword": ""
  };
  String errors = "";

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
        if (input['name'] != "" &&
            input['phoneNumber'] != "" &&
            input['password'] != "" &&
            input['email'] != "" &&
            input['password'] == input['confirmPassword'])
          Container(child: mutationComponent()),
      ],
    );
  }

  Widget bottom(RunMutation mutation, bool isLoading) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TeritoryButton(
            text: "Back",
            onpressed: () {
              Navigator.pop(context);
            },
          ),
          isLoading
              ? CupertinoActivityIndicator()
              : PrimaryButtonWidget(
                  buttonText: "Next",
                  onPressed: () {
                    mutation({
                      "name": input['name'],
                      "phoneNumber": input['phoneNumber'],
                      "email": input['email'],
                      "password": input['password'],
                    });
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
          onChanged: (val) {
            setState(() {
              input["name"] = val;
            });
          },
        ),
        SizedBox(height: 20),
        CustomTextField(
          isNumeric: true,
          labelText: "Phone Number",
          onChanged: (val) {
            setState(() {
              input["phoneNumber"] = val;
            });
          },
        ),
        SizedBox(height: 20),
        CustomTextField(
          labelText: "Email Address",
          onChanged: (val) {
            setState(() {
              input["email"] = val;
            });
          },
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
          onChanged: (val) {
            setState(() {
              input["password"] = val;
            });
          },
          isSecure: true,
        ),
        SizedBox(height: 20),
        CustomTextField(
          labelText: "Confirm Password",
          onChanged: (val) {
            setState(() {
              input["confirmPassword"] = val;
            });
          },
          isSecure: true,
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

  Widget mutationComponent() {
    return Mutation(
      options: MutationOptions(
        document: customerRegister,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return bottom(runMutation, result.loading);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        final prefs = await SharedPreferences.getInstance();
        final appState = Provider.of<AppState>(context);

        if (resultData['customerRegister']['error'] != null) {
          setState(() {
            errors = resultData['customerRegister']['error']['message'];
          });
          return showDialog(
              context: context,
              builder: (context) => DialogStyle(content: errors));
        }

        if (resultData != null &&
            resultData['customerRegister']['error'] == null) {
          final user =
              UserModel.fromJson(resultData['customerRegister']['user']);
          if (user != null) {
            final String token = resultData['customerRegister']['jwtToken'];

            await prefs.setString('token', token);
            await prefs.setString('name', user.name);
            await prefs.setString('phone number', user.phoneNumber);
            appState.setToken(token);
            appState.setName(user.name);
            appState.setPhoneNumber(user.phoneNumber);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OTPScreen()),
            );
          }
        }
      },
    );
  }
}
