import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';

class WebviewScreen extends StatelessWidget {
  final Uri url;
  final String title1;
  final String title2;

  const WebviewScreen(
      {super.key, required this.url, required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha:0.5),
        title: AppBarHeaderText(
            text1: title1, text2: title2),
      ),
      body: WebViewApp(url: url),
    );
  }
}

class WebViewApp extends StatefulWidget {
  // const WebViewApp({super.key});
  final Uri url;
  const WebViewApp({super.key, required this.url});

  @override
  State<WebViewApp> createState() => _WebViewAppState(url: url);
}

class _WebViewAppState extends State<WebViewApp> {
  final Uri url;
  _WebViewAppState({required this.url});
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(url.toString()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}