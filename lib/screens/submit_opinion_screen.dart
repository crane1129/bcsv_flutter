import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmitOpinionScreen extends StatefulWidget {
  const SubmitOpinionScreen({Key? key}) : super(key: key);

  @override
  _SubmitOpinionScreenState createState() => _SubmitOpinionScreenState();
}

class _SubmitOpinionScreenState extends State<SubmitOpinionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();

  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent.withValues(alpha: 0.5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: AppBarHeaderText(
              text1: AppLocalizations.of(context)!.bridgewayOpinion, text2: ''),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Card(
            elevation: 3.0,
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).colorScheme.surface,
                      leading: Icon(Icons.question_answer,
                          color: kActiveIconColor(context)),
                      title: Text(AppLocalizations.of(context)!.opinionTitle,
                          style: kListSubtitleStyle(context)),
                      subtitle: Text(
                          AppLocalizations.of(context)!.opinionSubTitle,
                          style: kListSubtitleStyle(context)),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameCtrl,
                      maxLength: 100,
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Name',
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: contactCtrl,
                      maxLength: 200,
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Email or phone',
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter an email or phone number'
                          : null,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: messageCtrl,
                      maxLines: 5,
                      maxLength: 2000,
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Message',
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter your message'
                          : null,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isSubmitting
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              submitData();
                            },
                      child: isSubmitting
                          ? CircularProgressIndicator()
                          : Text(AppLocalizations.of(context)!.submit),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final data = {
      'name': nameCtrl.text.trim(),
      'contact': contactCtrl.text.trim(),
      'message': messageCtrl.text.trim(),
    };

    try {
      final res = await http.post(
        Uri.parse(kContactApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 200) {
        messageCtrl.clear();
        nameCtrl.clear();
        contactCtrl.clear();

        showSimpleNotification(
          Text("Thank you! Your opinion has been submitted."),
          background: Colors.green,
        );
      } else {
        String errorMessage = "Submission failed. Please try again later.";
        try {
          final body = jsonDecode(res.body);
          if (body is Map && body['error'] is String) {
            errorMessage = body['error'];
          }
        } catch (_) {
          // Keep the default message if the error body isn't JSON.
        }
        showSimpleNotification(
          Text(errorMessage),
          background: Colors.red,
        );
      }
    } catch (e) {
      showSimpleNotification(
        Text("An error occurred. Please try again."),
        background: Colors.red,
      );
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }
}
