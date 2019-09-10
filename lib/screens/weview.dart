import 'dart:async';

import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/screens/order_placed.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikipediaExplorer extends StatefulWidget {
  final String orderId;
  final totalprice;

  WikipediaExplorer({this.totalprice, this.orderId});
  @override
  _WikipediaExplorerState createState() => _WikipediaExplorerState();
}

class _WikipediaExplorerState extends State<WikipediaExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: WebView(
              initialUrl:
                  'http://cezhop.herokuapp.com/paywithpaytm?orderId=${widget.orderId}',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (string) {
                print('Currently in the URL ' + string);
                webViewController
                    .evaluateJavascript(
                        '(function(){return window.document.body.innerText})();')
                    .then((onValue) {
                  if (onValue == null) {
                    print('ERROR PUNDAAAAAAAS');
                  }
                  verifyIfTransactionComplete(
                      onValue, context, widget.totalprice);
                });
              },
              onWebViewCreated: (WebViewController wbController) {
                _controller.complete(wbController);
                webViewController = wbController;
              },
            ),
          ),
        ));
  }
}

bool verifyIfTransactionComplete(
    String onValue, BuildContext context, totalprice) {
  print(onValue);
  try {
    if (onValue.contains('TXN_SUCCESS')) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderPlaced(
                    isCOD: false,
                    totalPrice: totalprice,
                  )));
    } else if (onValue.contains('TXN_FAILURE') ||
        onValue.toLowerCase().contains("webpage not available") ||
        onValue.toLowerCase().contains('error')) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error Occured"),
                content: Text("Payment Failed"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigateScreens()));
                      },
                      child: Text("OK"))
                ],
              ));
    }
    return false;
  } catch (e) {
    return false;
  }
}
