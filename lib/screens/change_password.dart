import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/dialog_style.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/UserModel.dart';
import 'package:elec_mart_customer/screens/login.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'graphql/updateCustomerAddress.dart';

class ChangePassword extends StatefulWidget {
  final String phoneNumber;

  ChangePassword({this.phoneNumber});
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  Map<String, String> input = {
    "name": "",
    "phoneNumber": "",
    "email": "",
    "password": "",
    "confirmPassword": ""
  };
  bool isPasswordValid = true;

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
        choosePassword(),
        mutationComponent(),
      ],
    );
  }

  Widget texts() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          text("Enter Your New Password", 30, PRIMARY_COLOR, false),
        ],
      ),
    );
  }

  Widget choosePassword() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("Choose a password", 16, BLACK_COLOR, true),
          SizedBox(height: 30),
          CustomTextField(
            errorText: isPasswordValid ? null : "Atlease 6 characters needed",
            labelText: "Password",
            onChanged: (val) {
              setState(() {
                isPasswordValid = val.length >= 6;
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

  Widget mutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
        options: MutationOptions(
          document: updateCustomerAddress,
          context: {
            'headers': <String, String>{
              'Authorization': 'Bearer ${appState.jwtToken}',
            },
          },
        ),
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          return result.loading
              ? Center(child: CupertinoActivityIndicator())
              : Container(
                  padding: EdgeInsets.all(24),
                  child: PrimaryButtonWidget(
                      buttonText: "Continue",
                      onPressed: input['password'] != "" &&
                              input['password'] == input['confirmPassword'] &&
                              input["password"].length >= 6
                          ? () {
                              runMutation({
                                "password": input['password'],
                                "phoneNumber": widget.phoneNumber,
                                "otpToken": "something"
                              });
                            }
                          : null));
        },
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        onCompleted: (dynamic resultData) async {
          if (resultData['updateCustomerAccount']['error'] != null) {
            showDialog(
                context: context,
                builder: (context) => DialogStyle(
                    content: resultData['updateCustomerAccount']['error']
                        ['message']));
          } else {
            Fluttertoast.showToast(
                msg: "You've successfully Changed Your Password",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => Login()), (c) => false);
          }
        });
  }
}
