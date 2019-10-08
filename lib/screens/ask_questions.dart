import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:flutter/material.dart';

class AskQuestion extends StatefulWidget {
  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
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
        height: 274,
        width: 363,
        child: CustomTextField(
          labelText: "Type your question here.",
        ),
      ),
      SizedBox(height: 50),
      Container(
        padding: EdgeInsets.all(24),
        child: PrimaryButtonWidget(
          buttonText: "Submit",
          onPressed: () {},
        ),
      )
    ]);
  }
}
