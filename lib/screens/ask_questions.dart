import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/dialog_style.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/profanityFilter.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/screens/graphql/add_question.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class AskQuestion extends StatefulWidget {
  final InventoryItemModel inventory;

  AskQuestion({this.inventory});

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  String userQuestion = "";
  String errors = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(children: <Widget>[
      AppTitleWidget(title: "Ask a question"),
      SizedBox(height: 50),
      Container(
        padding: EdgeInsets.all(24),
        child: CustomTextField(
          onChanged: (v) {
            setState(() {
              userQuestion = v;
            });
            if (ProfanityFilter().hasProfanity(userQuestion)) {
              showDialog(
                  context: context,
                  builder: (context) => DialogStyle(
                        content: "Don't Include Vulgar Words",
                        title: "Vulgar Word Found",
                      ));
            }
          },
          maxLine: 10,
          labelText: "Type your question here.",
        ),
      ),
      SizedBox(height: 50),
      if (userQuestion != "" &&
          ProfanityFilter().hasProfanity(userQuestion) == false)
        Container(padding: EdgeInsets.all(24), child: mutationComponent())
    ]);
  }

  Widget mutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: addQuestion,
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
                      "questionText": userQuestion,
                    });
                  },
                ),
              );
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        if (resultData['addQuestion']['error'] != null) {
          setState(() {
            errors = resultData['addQuestion']['error']['message'];
          });
          return showDialog(
              context: context,
              builder: (context) => DialogStyle(content: errors));
        }
        if (resultData != null && resultData['addQuestion']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }
}
