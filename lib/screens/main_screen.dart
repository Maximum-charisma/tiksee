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
            child: Listener(
              onPointerMove: (moveEvent) {
                if (moveEvent.delta.dx > 30) {
                  _webViewController.currentUrl().then(
                    (value) {
                      if (value != 'https://tiksee.ru') {
                        _webViewController.goBack();
                      }
                    },
                  );
                }
              },
              child: WebView(
                onWebViewCreated: (controller) {
                  setState(() {
                    _webViewController = controller;
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
}
