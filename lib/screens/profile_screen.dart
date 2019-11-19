import 'dart:convert';

import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/setting_option.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/UserModel.dart';
import 'package:elec_mart_customer/screens/graphql/fcm_integreate_token.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'change_number.dart';
import 'edit_address.dart';
import 'edit_name.dart';
import 'graphql/getCustomerInfo.dart';
import 'graphql/get_vendorinfo.dart';
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
          Container(padding: EdgeInsets.only(top: 24)),
          textWidget('Profile', TextAlign.center, BLACK_COLOR, 16),
          Container(padding: EdgeInsets.only(top: 40)),
          textWidget('${appState.name}', TextAlign.center, PRIMARY_COLOR, 24),
          textWidget(
              '${appState.phoneNumber}', TextAlign.center, BLACK_COLOR, 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TeritoryButton(
                text: 'Edit Name',
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditName()),
                  );
                },
              ),
            ],
          ),
          Container(padding: EdgeInsets.only(top: 20)),
          getAddressQuery(),
          Container(padding: EdgeInsets.only(top: 20)),
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
          Container(padding: EdgeInsets.only(top: 10)),
          getAdminInfo(),
          Container(padding: EdgeInsets.only(top: 10)),
          notifyMutationComponent(),
          Container(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'About app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PRIMARY_COLOR.withOpacity(0.75),
                            fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(height: 16),
                          Image.asset(
                            'assets/images/dark_logo.png',
                            height: 200,
                          ),
                          Text(
                            '© BeShoppi 2019',
                            style: TextStyle(
                              color: BLACK_COLOR,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'version 1.0',
                            style: TextStyle(
                              color: BLACK_COLOR,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: PRIMARY_COLOR.withOpacity(0.7),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/flutter_logo.png'),
                                Container(width: 12),
                                Text(
                                  'Made with Flutter',
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(height: 12),
                          GestureDetector(
                            onTap: () {
                              launch(
                                  'https://roshanrahman.github.io/emart-web/about.html');
                            },
                            child: Text(
                              'About the developers',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: PRIMARY_COLOR,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: PRIMARY_COLOR.withOpacity(0.7),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            child: PrimaryButtonWidget(
                              buttonText: 'Okay',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
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

  launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                textWidget(
                    '${address["pinCode"]}', TextAlign.start, BLACK_COLOR, 16),
                textWidget('${address["phoneNumber"]}', TextAlign.start,
                    PRIMARY_COLOR, 16),
              ],
            ),
    );
  }

  Widget phoneNumberRow(String number) {
    if (number != null)
      return InkWell(
        onTap: () {
          launch("tel://$number");
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(number),
              Icon(Icons.call),
            ],
          ),
        ),
      );
    else
      return Container();
  }

  Widget helpLineAndMailButton(
      email, phoneNumber1, phoneNumber2, phoneNumber3) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            launchURL(email, 'Regarding Be Shoppi Vendor App', 'Write here');
          },
          child: SettingsOption(
            title: 'Mail your queries',
            color: BLACK_COLOR,
          ),
        ),
        Container(padding: EdgeInsets.only(top: 3)),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(24),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text(
                    'Choose a number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(height: 12),
                      phoneNumberRow(phoneNumber1),
                      phoneNumberRow(phoneNumber2),
                      phoneNumberRow(phoneNumber3),
                      Container(height: 12),
                    ],
                  ),
                );
              },
            );
          },
          child: SettingsOption(
            title: 'Help Line',
            color: BLACK_COLOR,
          ),
        ),
      ],
    );
  }

  Widget getAdminInfo() {
    return Query(
      options: QueryOptions(
        document: getVendorInfo,
        fetchPolicy: FetchPolicy.noCache,
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getVendorInfo']['user'] != null) {
          final user = UserModel.fromJson(result.data['getVendorInfo']['user']);
          return helpLineAndMailButton(
              user.email,
              user.phoneNumber,
              result.data["getVendorInfo"]["user"]["alternativePhone1"],
              result.data["getVendorInfo"]["user"]["alternativePhone2"]);
        }
        return Container();
      },
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
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        String addressString =
            result.data["getCustomerInfo"]["user"]["address"];
        Map address = {};
        if (addressString != null) address = jsonDecode(addressString);
        return addressContainer(address);
      },
    );
  }

  Widget notifyMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
        options: MutationOptions(
          document: fcmIntegerateToken,
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
          return InkWell(
            onTap: () async {
              final appState = Provider.of<AppState>(context);
              final cartState = Provider.of<CartState>(context);
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              appState.clearApp();
              cartState.clearCart();

              runMutation({"fcmToken": null});

              Fluttertoast.showToast(
                  msg: "You've successfully logged out",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: SettingsOption(
              title: 'Log Out',
              color: BLACK_COLOR,
            ),
          );
        },
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        onCompleted: (dynamic resultData) async {});
  }
}
