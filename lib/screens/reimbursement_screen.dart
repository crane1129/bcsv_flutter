import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class ReimbursementScreen extends StatelessWidget {
  ReimbursementScreen({required this.selectedUrl});

  final String selectedUrl;

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: selectedUrl,
      appBar: new AppBar(
        title: new Text("Widget webview"),
      ),
    );
  }
}
