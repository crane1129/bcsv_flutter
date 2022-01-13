import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';

class WebviewScreen extends StatelessWidget {
  final String url;
  final String title1;
  final String title2;

  WebviewScreen(
      {required this.url, required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(
            text1: title1, text2: title2),
      ),
      body: WebViewClass(url: url),
    );
  }
}

class WebViewClass extends StatefulWidget {
  final String url;

  WebViewClass({required this.url});
  _WebViewClassState createState() => _WebViewClassState(url: url);
}

class _WebViewClassState extends State<WebViewClass> {
  _WebViewClassState({required this.url});
  final String url;
  int position = 1;
  final key = UniqueKey();

  doneLoading(String a) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String a) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: position,
      children: <Widget>[
        WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          key: key,
          onPageFinished: doneLoading,
          onPageStarted: startLoading,
        ),
        Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ))
      ],
    );
  }
}
