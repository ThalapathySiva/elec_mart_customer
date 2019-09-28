import 'dart:convert';

import 'package:elec_mart_customer/components/setting_option.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_app.dart';
import 'change_number.dart';
import 'edit_address.dart';
import 'graphql/getCustomerInfo.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 20)),
          textWidget('Profile', TextAlign.center, BLACK_COLOR, 16),
          Container(padding: EdgeInsets.only(top: 40)),
          textWidget('${appState.name}', TextAlign.center, PRIMARY_COLOR, 24),
          textWidget(
              '${appState.phoneNumber}', TextAlign.center, BLACK_COLOR, 16),
          Container(padding: EdgeInsets.only(top: 20)),
          getAddressQuery(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditAddress(showBackButton: true)),
              );
            },
            child: SettingsOption(
              title: 'Edit your Address',
              color: BLACK_COLOR,
            ),
          ),
          Container(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeNumber()),
              );
            },
            child: SettingsOption(
              title: 'Change Phone Number',
              color: BLACK_COLOR,
            ),
          ),
          InkWell(
            onTap: () {
              launch("tel://8144479784");
            },
            child: SettingsOption(
              title: 'HelpLine',
              color: BLACK_COLOR,
            ),
          ),
          Container(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () async {
              final appState = Provider.of<AppState>(context);
              final cartState = Provider.of<CartState>(context);
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              appState.clearApp();
              cartState.clearCart();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: SettingsOption(
              title: 'Log Out',
              color: BLACK_COLOR,
            ),
          ),
          Container(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutApp()),
              );
            },
            child: SettingsOption(
              title: 'About app',
              color: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }

  Widget textWidget(
      String text, TextAlign textAlign, Color color, double size) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget addressContainer(Map address) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
          borderRadius: BorderRadius.circular(12)),
      child: address.length == 0
          ? null
          : Column(
              children: <Widget>[
                textWidget('Your Address', TextAlign.start, PRIMARY_COLOR, 18),
                textWidget('This will be used for delivery', TextAlign.start,
                    PRIMARY_COLOR.withOpacity(0.35), 12),
                Container(margin: EdgeInsets.only(top: 20)),
                textWidget(
                    '${address["name"]}', TextAlign.start, BLACK_COLOR, 16),
                textWidget('${address["addressLine"]},', TextAlign.start,
                    BLACK_COLOR, 16),
                textWidget(
                    '${address["city"]}', TextAlign.start, BLACK_COLOR, 16),
                textWidget('${address["phoneNumber"]}', TextAlign.start,
                    PRIMARY_COLOR, 16),
              ],
            ),
    );
  }

  Widget getAddressQuery() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getCustomerInfo,
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
        pollInterval: 2,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        String addressString =
            result.data["getCustomerInfo"]["user"]["address"];
        Map address = {};
        if (addressString != null) address = jsonDecode(addressString);
        return addressContainer(address);
      },
    );
  }
}
