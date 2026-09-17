import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, required this.initialUrl, super.key});

  final WebViewController controller;
  final Uri initialUrl;
  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  // The app already provides its own AppBar/drawer navigation for these
  // homepage pages, so the homepage's own <header> nav is redundant and
  // lets users tap into a different app "tab" from inside the WebView.
  // This guard only applies to the main homepage domain (not e.g. the
  // external link hub, which is meant to be browsed freely).
  static const _guardedHost = 'bridgeway.online';

  var loadingPercentage = 0;

  bool get _isGuardedHost => widget.initialUrl.host == _guardedHost;

  bool _isAllowedNavigation(String url) {
    if (!_isGuardedHost) return true;
    final target = Uri.tryParse(url);
    if (target == null) return true;
    final isSameHost = target.host == widget.initialUrl.host;
    final isDifferentPath = target.path != widget.initialUrl.path;
    return !(isSameHost && isDifferentPath);
  }

  @override
  void initState() {
    super.initState();

    widget.controller
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
          if (_isGuardedHost) {
            // Hide the homepage's own nav header (it duplicates this
            // screen's AppBar/drawer) and watch for client-side route
            // changes (Next.js <Link> uses history.pushState, which
            // onNavigationRequest below does not see) so we can snap back
            // to this screen's intended page instead of silently drifting
            // to another app "tab".
            widget.controller.runJavaScript('''
              document.querySelector('header')?.remove();
              (function() {
                var lastPath = window.location.pathname;
                var notifyIfChanged = function() {
                  if (window.location.pathname !== lastPath) {
                    NavGuard.postMessage(window.location.href);
                  }
                };
                var originalPushState = history.pushState;
                history.pushState = function() {
                  originalPushState.apply(history, arguments);
                  notifyIfChanged();
                };
                window.addEventListener('popstate', notifyIfChanged);
              })();
            ''');
          }
        },
        onNavigationRequest: (navigation) {
          if (_isAllowedNavigation(navigation.url)) {
            return NavigationDecision.navigate;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('앱의 메뉴를 이용해 이동해 주세요.')),
          );
          return NavigationDecision.prevent;
        },
      )
    )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..addJavaScriptChannel(
        'NavGuard',
        onMessageReceived: (message) {
          // The page navigated client-side to a different route than the
          // one this screen is meant to show; snap back to it.
          widget.controller.loadRequest(widget.initialUrl);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}