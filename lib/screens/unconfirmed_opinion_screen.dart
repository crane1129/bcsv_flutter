import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/appbar_header_text.dart';
import '../utilities/constants.dart';
import 'package:flutter/services.dart';

class UnconfirmedOpinionsScreen extends StatefulWidget {
  const UnconfirmedOpinionsScreen({Key? key}) : super(key: key);

  @override
  _UnconfirmedOpinionsScreenState createState() =>
      _UnconfirmedOpinionsScreenState();
}

class _UnconfirmedOpinionsScreenState extends State<UnconfirmedOpinionsScreen> {
  late Future<List<Map<String, dynamic>>> _futureOpinions;

  @override
  void initState() {
    super.initState();
    _futureOpinions = fetchOpinions();
  }

  Future<List<Map<String, dynamic>>> fetchOpinions() async {
    final uri =
        Uri.https('www.bridgeway.online', '/_functions/unconfirmedOpinions');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(json['result']);
    } else {
      throw Exception("Failed to load unconfirmed opinions");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.unconfirmed_opinion,
            text2: ''),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureOpinions,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("❌ ${snapshot.error}"));
          }

          final opinions = snapshot.data!;
          if (opinions.isEmpty) {
            return Center(child: Text("✅ No unconfirmed opinions."));
          }

          return ListView.builder(
            itemCount: opinions.length,
            itemBuilder: (context, index) {

              final item = opinions[index];
              final rawDate = item['dateCreated'];
              final formattedDate = rawDate != null
                  ? DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.parse(rawDate))
                  : 'Unknown date';
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(item['category'] ?? "No Category"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(item['message'] ?? ""),
                      if (item['name']?.isNotEmpty ?? false)
                        Text("👤 ${item['name']}"),
                      if (item['email']?.isNotEmpty ?? false)
                        Text("📧 ${item['email']}"),
                      if ((item['attachmentUrl'] ?? '').isNotEmpty) ...[
                        // 📎 Show file name
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0),
                        //   child: Text(
                        //     "📄 ${Uri.parse(item['attachmentUrl']).pathSegments.last}",
                        //     style: TextStyle(fontStyle: FontStyle.normal),
                        //   ),
                        // ),

                        // 🖼️ Show image preview (if it's an image)
                        if (isImageFile(item['attachmentUrl']))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Image.network(
                              item['attachmentUrl'],
                              fit: BoxFit.cover,
                              height: 200,
                              errorBuilder: (_, __, ___) =>
                                  Text("❌ Image failed to load"),
                            ),
                          ),

                        // 📥 Download button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            icon: Icon(Icons.download),
                            label: Text("Download"),
                            onPressed: () async {
                              final url = item['attachmentUrl'];
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("❌ Failed to open file.")),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                      SizedBox(height: 5),
                      Text("📅 $formattedDate"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.check_circle_outline),
                            label: Text("Confirm"),
                            onPressed: () => confirmOpinion(item['id']),
                          ),
                          SizedBox(width: 12), // spacing between buttons
                          ElevatedButton.icon(
                            icon: Icon(Icons.copy),
                            label: Text("Copy"),
                            onPressed: () {
                              final buffer = StringBuffer();
                              buffer.writeln("Category: ${item['category'] ?? ''}");
                              buffer.writeln("Message: ${item['message'] ?? ''}");
                              if ((item['name'] ?? '').isNotEmpty) buffer.writeln("Name: ${item['name']}");
                              if ((item['email'] ?? '').isNotEmpty) buffer.writeln("Email: ${item['email']}");
                              buffer.writeln("Date: $formattedDate");
                              Clipboard.setData(ClipboardData(text: buffer.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('📋 Copied to clipboard')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> confirmOpinion(String id) async {
    final uri = Uri.https('www.bridgeway.online', '/_functions/confirmOpinion');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _futureOpinions = fetchOpinions(); // Refresh the list
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Opinion confirmed')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to confirm opinion')),
      );
    }
  }

  bool isImageFile(String url) {
    try {
      final uri = Uri.parse(url);
      final path = uri.path.toLowerCase(); // get only the path, excluding query
      return path.endsWith('.jpg') ||
          path.endsWith('.jpeg') ||
          path.endsWith('.png') ||
          path.endsWith('.gif') ||
          path.endsWith('.webp');
    } catch (_) {
      return false;
    }
  }
}
