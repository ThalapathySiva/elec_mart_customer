import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/graphql/updateCustomerAddress.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAddress extends StatefulWidget {
  final showBackButton;

  EditAddress({this.showBackButton = false});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  Map input = {
    "Name": "",
    "Mobile Number": "",
    "Address": "",
    "Landmark": "",
    "City": ""
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(
      children: <Widget>[
        widget.showBackButton ? AppTitleWidget() : Container(),
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
            labelText: "Name",
            onChanged: (val) {
              setState(() {
                input['Name'] = val;
              });
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "Street/Locality",
            onChanged: (val) {
              setState(() {
                input['Address'] = val;
              });
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "Landmark",
            onChanged: (val) {
              setState(() {
                input['Landmark'] = val;
              });
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            labelText: "City",
            onChanged: (val) {
              setState(() {
                input['City'] = val;
              });
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            maxLength: 10,
            isNumeric: true,
            labelText: "Phone Number",
            onChanged: (val) {
              setState(() {
                input['Mobile Number'] = val;
              });
            },
          ),
          SizedBox(height: 50),
          if (input['Name'] != "" &&
              input['Mobile Number'] != "" &&
              input['Address'] != "" &&
              input['Landmark'] != "" &&
              input['City'] != "")
            Container(
              height: 50,
              width: 360,
              child: mutationComponent(),
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
            : PrimaryButtonWidget(
                buttonText: "Save Changes",
                onPressed: () {
                  runMutation({
                    "address": {
                      "name": input['Name'],
                      "phoneNumber": input['Mobile Number'],
                      "addressLine": input["Address"],
                      "landmark": input["Landmark"],
                      "city": input['City']
                    }
                  });
                },
              );
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('address', true);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavigateScreens()),
            (v) => false);
      },
    );
  }
}
