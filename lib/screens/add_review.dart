import 'dart:convert';

import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/cart_item.dart';
import 'package:elec_mart_customer/components/dialog_style.dart';
import 'package:elec_mart_customer/components/imageSelectionWidget.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/rating.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/constants/profanityFilter.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/screens/graphql/add_review.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  final InventoryItemModel inventory;

  AddReview({this.inventory});

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  String errors = "";
  double userRating = 0;
  List inventoryImageUrls = [];

  String userReview = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(children: <Widget>[
      AppTitleWidget(title: "Add a review"),
      Container(
          padding: EdgeInsets.all(24),
          child: CartItem(
            imageUrl: widget.inventory.images[0],
            name: widget.inventory.name,
            currentPrice: widget.inventory.sellingPrice.toString(),
          )),
      Container(
          padding: EdgeInsets.all(24),
          child: Text(
            "How many stars would you give this product?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
      Center(
        child: Container(
            padding: EdgeInsets.all(24),
            child: RatingStar(
              size: 53,
              borderColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR,
              onratingChanged: (v) {
                setState(() {
                  userRating = v;
                });
              },
              rating: userRating,
            )),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ImageSelectionWidget(
            existingUrl:
                inventoryImageUrls.length == 0 ? null : inventoryImageUrls[0],
            onUserImageSet: (imgUrl) {
              setState(() {
                if (inventoryImageUrls.length >= 1)
                  inventoryImageUrls.removeAt(0);
                inventoryImageUrls.insert(0, imgUrl);
              });
            },
          ),
          if (inventoryImageUrls.length >= 1)
            ImageSelectionWidget(
              existingUrl:
                  inventoryImageUrls.length < 2 ? null : inventoryImageUrls[1],
              onUserImageSet: (imgUrl) {
                setState(() {
                  if (inventoryImageUrls.length >= 2)
                    inventoryImageUrls.removeAt(1);
                  inventoryImageUrls.insert(1, imgUrl);
                });
              },
            ),
          if (inventoryImageUrls.length >= 2)
            ImageSelectionWidget(
              existingUrl:
                  inventoryImageUrls.length < 3 ? null : inventoryImageUrls[2],
              onUserImageSet: (imgUrl) {
                setState(() {
                  if (inventoryImageUrls.length >= 3)
                    inventoryImageUrls.removeAt(2);
                  inventoryImageUrls.insert(2, imgUrl);
                });
              },
            ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (inventoryImageUrls.length >= 3)
              ImageSelectionWidget(
                existingUrl: inventoryImageUrls.length < 4
                    ? null
                    : inventoryImageUrls[3],
                onUserImageSet: (imgUrl) {
                  setState(() {
                    if (inventoryImageUrls.length >= 4)
                      inventoryImageUrls.removeAt(3);
                    inventoryImageUrls.insert(3, imgUrl);
                  });
                },
              ),
            if (inventoryImageUrls.length >= 4)
              ImageSelectionWidget(
                existingUrl: inventoryImageUrls.length < 5
                    ? null
                    : inventoryImageUrls[4],
                onUserImageSet: (imgUrl) {
                  setState(() {
                    if (inventoryImageUrls.length >= 5)
                      inventoryImageUrls.removeAt(4);
                    inventoryImageUrls.insert(4, imgUrl);
                  });
                },
              ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(24),
        child: Text(
          "Tell us why. Give us your review of the product.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(24),
        child: CustomTextField(
          maxLine: 10,
          labelText: "Type your question here.",
          onChanged: (v) {
            setState(() {
              userReview = v;
            });
            if (ProfanityFilter().hasProfanity(userReview)) {
              showDialog(
                  context: context,
                  builder: (context) => DialogStyle(
                        content: "Don't Include Vulgar Words",
                        title: "Vulgar Word Found",
                      ));
            }
          },
        ),
      ),
      SizedBox(height: 50),
      Container(
          padding: EdgeInsets.all(24),
          child: Text(
            "Your feedback helps us improve our services. Thank you for taking the time to participate.",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: LIGHT_BLUE_COLOR),
          )),
      SizedBox(height: 10),
      if (userRating != 0 &&
          userReview != "" &&
          ProfanityFilter().hasProfanity(userReview) == false)
        mutationComponent()
    ]);
  }

  Widget mutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: addReview,
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
            ? Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoActivityIndicator())
            : Container(
                padding: EdgeInsets.all(24),
                child: PrimaryButtonWidget(
                  buttonText: "Submit",
                  onPressed: () {
                    runMutation({
                      "inventoryId": widget.inventory.id,
                      "rating": userRating,
                      "text": userReview,
                      "images": jsonEncode(inventoryImageUrls),
                    });
                  },
                ),
              );
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        if (resultData['addReview']['error'] != null) {
          setState(() {
            errors = resultData['addReview']['error']['message'];
          });
          return showDialog(
              context: context,
              builder: (context) => DialogStyle(content: errors));
        }
        if (resultData != null && resultData['addReview']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }
}
