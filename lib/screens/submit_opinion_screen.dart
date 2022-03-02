import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/services/gsheet_access.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitOpinionScreen extends StatefulWidget {
  const SubmitOpinionScreen({Key? key}) : super(key: key);

  @override
  _SubmitOpinionScreenState createState() => _SubmitOpinionScreenState();
}

class _SubmitOpinionScreenState extends State<SubmitOpinionScreen> {
  var maxLines = 5;
  String myMessage = '';

  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getMessageData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          title: AppBarHeaderText(
              text1: AppLocalizations.of(context)!.bridgewayOpinion, text2: ''),
        ),
        body: Container(
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(10),
            child: Card(
              color: kActiveCardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ListTile(
                    leading:
                        Icon(Icons.question_answer, color: kActiveIconColor),
                    title: Text(AppLocalizations.of(context)!.opinionTitle,
                        style: kListTitleStyle),
                    subtitle: Text(
                        AppLocalizations.of(context)!.opinionSubTitle,
                        style: kListSubtitleStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: fieldText,
                      style: TextStyle(color: Colors.black),
                      maxLines: maxLines,
                      keyboardType: TextInputType.multiline,
                      maxLength: 200,
                      decoration: kTextFieldInputDecoration,
                      onChanged: (value) {
                        myMessage = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      submitData();
                    },
                    child: Text(AppLocalizations.of(context)!.submit),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitData() {
    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    if (myMessage.isEmpty) {
      showSimpleNotification(
          Text(
            "Please enter your opinion.",
          ),
          leading: Icon(Icons.warning_amber_outlined),
          background: Colors.red,
          elevation: 5);
    } else {
      setState(() {
        final message = {
          'Date': formattedCurrentDate,
          "Category": "Question",
          "Comment": myMessage
        };
        GoogleMessageSheet.insert([message]);
        FocusScope.of(context).unfocus();
        clearText();
      });
    }
  }
}
