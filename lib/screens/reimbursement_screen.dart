import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class ReimbursementScreen extends StatelessWidget {
  ReimbursementScreen({required this.selectedUrl});

  final String selectedUrl;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      appBar: new AppBar(
        title: const Text('Widget webview'),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.redAccent,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}
