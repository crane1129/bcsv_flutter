// ✅ SubmitOpinionScreen with File Picker support
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class SubmitOpinionScreen extends StatefulWidget {
  const SubmitOpinionScreen({Key? key}) : super(key: key);

  @override
  _SubmitOpinionScreenState createState() => _SubmitOpinionScreenState();
}

class _SubmitOpinionScreenState extends State<SubmitOpinionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  String selectedCategory = 'Suggestion';
  bool isSubmitting = false;
  PlatformFile? pickedFile;

  final List<String> categories = [
    'Prayer Request',
    'Suggestion',
    'Complaint',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent.withValues(alpha:0.5),
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
            elevation:3.0,
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
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(labelText: 'Category'),
                      items: categories
                          .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c),
                              ))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => selectedCategory = val!),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: messageCtrl,
                      maxLines: 5,
                      maxLength: 200,
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Message (required)',
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter your message'
                          : null,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: nameCtrl,
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Name (optional)',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Email (optional)',
                      ),
                    ),
                    SizedBox(height: 16),
                    OutlinedButton.icon(
                      icon: Icon(Icons.attach_file),
                      label: Text(pickedFile != null
                          ? pickedFile!.name
                          : 'Attach File (optional)'),
                      onPressed: pickFile,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: isSubmitting
                          ? null
                          : () {
                        FocusScope.of(context).unfocus(); // Hide keyboard
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

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(withData: true); // force loading bytes
    if (result != null && result.files.single.bytes != null) {
      setState(() => pickedFile = result.files.single);
    } else {
      showSimpleNotification(
        Text("⚠️ Failed to load file or file is empty"),
        background: Colors.orange,
      );
    }
  }


  Future<void> submitData() async {
    FocusScope.of(context).unfocus(); // ✅ Hide the keyboard

    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);
    FocusScope.of(context).unfocus();

    final data = {
      'category': selectedCategory,
      'message': messageCtrl.text.trim(),
      'name': nameCtrl.text.trim().isEmpty ? null : nameCtrl.text.trim(),
      'email': emailCtrl.text.trim().isEmpty ? null : emailCtrl.text.trim(),
      'fileName': pickedFile?.name ?? '',
      'fileData': pickedFile != null ? base64Encode(pickedFile!.bytes!) : null
    };

    try {
      final uri =
          Uri.https('www.bridgeway.online', '/_functions/opinionSubmit');
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 200) {
        messageCtrl.clear();
        nameCtrl.clear();
        emailCtrl.clear();
        setState(() => pickedFile = null);

        showSimpleNotification(
          Text("Thank you! Your opinion has been submitted."),
          background: Colors.green,
        );
      } else {
        showSimpleNotification(
          Text("Submission failed. Please try again later."),
          background: Colors.red,
        );
      }
    } catch (e) {
      showSimpleNotification(
        Text("An error occurred. Please try again."),
        background: Colors.red,
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }
}
