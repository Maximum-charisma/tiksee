import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiksee/update.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Completer _controllerCompleter = Completer();
  late WebViewController _webViewController;

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    UpdateApp().checkVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            top: true,
            bottom: false,
            child: WillPopScope(
              onWillPop: () => _goBack(context),
              child: WebView(
                gestureNavigationEnabled: true,
                onWebViewCreated: (WebViewController webViewController) {
                  setState(() {
                    _controllerCompleter.future
                        .then((value) => _webViewController = value);
                    _controllerCompleter.complete(webViewController);
                  });
                },
                initialUrl: 'https://tiksee.ru',
                javascriptMode: JavascriptMode.unrestricted,
                javascriptChannels: <JavascriptChannel>{
                  JavascriptChannel(
                      name: 'IosJsGateway',
                      onMessageReceived: (JavascriptMessage message) async {})
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    _webViewController.canGoBack();
    return Future.value(false);
  }
}
