import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';


class Dialogs{
  bool isPressedOK = false;
  bool isPressedConfirm = false;

  information(BuildContext context, String title, String description){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            )
          ),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context),
                child: Text('OK'))
          ]
        );
      }
    );
  }

  /*
  What it does: It will pop up and disappear automatically in given duration of time.
  How to use waiting?
  1. In caller:
    onPress: () async{
      dialog.waiting(context, 'title', 'description);
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
   */
  waiting(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(description),
                    ],
                  )
              ),
          );
        }
    );
  }

  _confirmResult(bool isConfirmed, BuildContext context){
    isPressedConfirm = isConfirmed;
    Navigator.pop(context);
  }

  /*
  How to use confirm dialog:
    onPressed: () async {
    await dialog.confirm(context, 'Notification', 'description');
    if (dialog.isPressedConfirm){
       Your code here...;
    }
  */
  confirm(BuildContext context, String title, String description){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(description),
                    ],
                  )
              ),
              actions: <Widget>[
                // TextButton(onPressed: () => _confirmResult(false, context),
                //     child: Text('Cancel')),
                TextButton(onPressed: () => _confirmResult(true, context),
                    child: Text('Confirm'))
              ]
          );
        }
    );
  }
}