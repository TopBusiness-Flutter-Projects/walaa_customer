import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class paymetPage extends StatefulWidget {
  final String url;

  const paymetPage({Key? key, required this.url}) : super(key: key);

  @override
  State<paymetPage> createState() => _paymetPageState(url: url);
}

class _paymetPageState extends State<paymetPage> {
  String url;

  _paymetPageState({required this.url});

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    late WebViewController _webController;

    // print("sssss${paymentDataModel.token}");

    return WebView(
      initialUrl: url,
      onPageStarted: (url) {},
      onWebViewCreated: (WebViewController webViewController) {
        webViewController.loadUrl(
          url,
        );
        _webController = webViewController;

        // _controller.complete(webViewController );
      },
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (String url) {
        if (url.contains("status=1")) {
          Fluttertoast.showToast(
              msg: 'sucess pay', // message
              toastLength: Toast.LENGTH_SHORT, // length
              gravity: ToastGravity.BOTTOM, // location
              timeInSecForIosWeb: 1 // duration
              );
          Navigator.pop(context);
        } else if (url.contains("status=2")) {
          _webController.loadUrl(url);
        } else if (url.contains("status=0")) {
          Fluttertoast.showToast(
              msg: 'faild pay', // message
              toastLength: Toast.LENGTH_SHORT, // length
              gravity: ToastGravity.BOTTOM, // location
              timeInSecForIosWeb: 1 // duration
              );
          Navigator.pop(context);
        }
      },
    );
  }
}
