import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
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

  WebViewController controller = WebViewController();
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
            if(progress<100){
              setState(() {
                opacity=1;
              });
            }else{
              setState(() {
                opacity=0;
              });
            }

          },
          onPageStarted: (String url) {},
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
              controller.loadRequest(Uri.parse(url));
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
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));

    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    // late WebViewController _webController;
    //
    // // print("sssss${paymentDataModel.token}");

    return Stack(
      children: [
        WebViewWidget(controller: controller),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Opacity(
            opacity: opacity,
            child: Center(
              child: ShowLoadingIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
