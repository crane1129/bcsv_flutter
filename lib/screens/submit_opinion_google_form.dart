import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitOpinionViaGoogleFormScreen extends StatefulWidget {
  const SubmitOpinionViaGoogleFormScreen({Key? key}) : super(key: key);

  @override
  _SubmitOpinionViaGoogleFormScreenState createState() => _SubmitOpinionViaGoogleFormScreenState();
}

class _SubmitOpinionViaGoogleFormScreenState extends State<SubmitOpinionViaGoogleFormScreen> {
  var maxLines = 5;
  String myMessage = '';

  // List of categories
  final List<String> _categories = [
    'General request',
    'Pray request',
    'Suggestion',
    'Complaint',
    'Etc',
  ];

  // Selected category
  String? _selectedCategory; // Variable to store the selected category
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: AppBarHeaderText(
              text1: AppLocalizations.of(context)!.bridgewayOpinion, text2: ''),
        ),
        body: Container(
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(10),
            child: Card(
              color: kOpinionCardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.question_answer, color: kActiveIconColor),
                      title: Text(
                          AppLocalizations.of(context)!.opinionTitle,
                          style: kLabelTextStyle),
                      subtitle: Text(
                        AppLocalizations.of(context)!.opinionSubTitle,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      dropdownColor: kMainThemeColor,
                      style: kBodyTextStyle,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          labelText: 'Category'
                      ),
                      value: _selectedCategory,
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: kBodyTextStyle,
                      maxLines:5,
                      controller: _messageController,
                      decoration: InputDecoration(
                          labelText: 'Message',
                          contentPadding: EdgeInsets.all(10.0),
                          // hintText: 'Enter message'
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: kBodyTextStyle,
                      controller: _nameController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          labelText: 'Name',
                          hintText: 'Optional'
                      ),
                      keyboardType: TextInputType.name,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter an email';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitForm();
                            }
                          },
                          child: Text('Submit'),
                        ),
                        SizedBox(width: 60),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              clearData();
                            }
                          },
                          child: Text('Clear'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Function to clear the data
  void clearData() {
    setState(() {
      _selectedCategory = null; // Clear category selection
      _messageController.clear();
      _nameController.clear();
    });
  }

// Function to submit the data to Google Forms
  Future<void> _submitForm() async {
    final category = _selectedCategory;
    final message = _messageController.text;
    final name = _nameController.text;

    // Replace this with your Google Form action URL and entry IDs
    final Uri googleFormUrl = ApiEndpoint.apiMap['FEEDBACK'];

    // Add the required hidden fields
    final Map<String, String> formData = {
      'entry.1591633300': category ?? '', // Replace with your actual entry ID for category
      'entry.326955045': message,
      'entry.1857024054': name
    };

    try {
      final response = await http.post(
        googleFormUrl,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Form submitted successfully!"),
        ));
        clearData();

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to submit the form!"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
      ));
    }
  }
}
