import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/UserModel.dart';
import 'package:elec_mart_customer/screens/create_account.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'graphql/customerLogin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map input = {"phoneNumber": "", "password": ""};

  String errors = "";

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
          padding: EdgeInsets.symmetric(horizontal: 100),
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
            onChanged: (val) {
              setState(() {
                input["phoneNumber"] = val;
              });
            },
          ),
          SizedBox(height: 20),
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
          if (input['phoneNumber'] != "" && input['password'] != "")
            mutationComponent()
          else
            Container(height: 50),
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

  Widget mutationComponent() {
    return Mutation(
      options: MutationOptions(
        document: customerLogin,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return result.loading
            ? Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoActivityIndicator())
            : Align(
                alignment: Alignment.bottomRight,
                child: PrimaryButtonWidget(
                  buttonText: "Login",
                  onPressed: () {
                    runMutation({
                      "phoneNumber": input['phoneNumber'],
                      "password": input['password'],
                    });
                  },
                ));
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        final prefs = await SharedPreferences.getInstance();
        final appState = Provider.of<AppState>(context);
        if (resultData['customerLogin']['error'] != null) {
          setState(() {
            errors = resultData['customerLogin']['error']['message'];
          });
        }
        if (resultData != null &&
            resultData['customerLogin']['error'] == null) {
          final user = UserModel.fromJson(resultData['customerLogin']['user']);
          if (user != null) {
            final String token = resultData['customerLogin']['jwtToken'];

            await prefs.setString('token', token);
            await prefs.setString('name', user.name);
            await prefs.setString('phone number', user.phoneNumber);
            appState.setToken(token);
            appState.setName(user.name);
            appState.setPhoneNumber(user.phoneNumber);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavigateScreens()),
            );
          }
        }
      },
    );
  }
}
