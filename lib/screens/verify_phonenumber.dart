import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/dialog_style.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/UserModel.dart';
import 'package:elec_mart_customer/screens/change_password.dart';
import 'package:elec_mart_customer/screens/login.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'graphql/customerValidate.dart';
import 'graphql/updateCustomerAddress.dart';
import 'otp.dart';

class VerifyPhonenumber extends StatefulWidget {
  @override
  _VerifyPhonenumber createState() => _VerifyPhonenumber();
}

class _VerifyPhonenumber extends State<VerifyPhonenumber> {
  String phoneNumber = "";
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
        validateMutation(),
      ],
    );
  }

  Widget texts() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          text("Enter Your Phone Number", 30, PRIMARY_COLOR, false),
        ],
      ),
    );
  }

  Widget textFields() {
    return Container(
      padding: EdgeInsets.all(24),
      child: CustomTextField(
        isNumeric: true,
        maxLength: 10,
        labelText: "Phone Number",
        onChanged: (val) {
          setState(() {
            phoneNumber = val;
          });
        },
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

  Widget validateMutation() {
    return Mutation(
      options: MutationOptions(
        document: customerValidate,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        return result.loading
            ? Center(child: CupertinoActivityIndicator())
            : Container(
                padding: EdgeInsets.all(24),
                child: PrimaryButtonWidget(
                    buttonText: "Continue",
                    onPressed: phoneNumber.length != 10
                        ? null
                        : () {
                            runMutation({"phoneNumber": phoneNumber});
                          }));
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        if (resultData["validateCustomerArguments"]["phoneNumber"] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(
                      phoneNumber: phoneNumber,
                      onOTPIncorrect: () {
                        print("SOMETHING WRONG HAPPENED!!!");
                      },
                      onOTPSuccess: () {
                        print('ON OTP SUCCESS HAS BEEN CALLED!!!');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangePassword(phoneNumber: phoneNumber)));
                      },
                    )),
          );
        } else {
          showDialog(
              context: context,
              builder: (context) => DialogStyle(content: "User Not Found"));
        }
      },
    );
  }
}
