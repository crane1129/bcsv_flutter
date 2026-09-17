import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bcsv_flutter_project/components/webview/stack.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';


class WebViewApp extends StatefulWidget {
  final Uri url;
  final String title1;
  final String title2;

  WebViewApp(
      {required this.url, required this.title1, required this.title2, super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState(url: url, title1: title1);
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  final Uri url;
  final String title1;

  _WebViewAppState(
      {required this.url, required this.title1});

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(url.toString()),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha:0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(text1: title1, text2: ''),
        // actions: [
        //   NavigationControls(controller: controller),
        // ],
      ),
      body: WebViewStack(controller: controller, initialUrl: url),
    );
  }
}